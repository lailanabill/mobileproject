import 'package:permission_handler/permission_handler.dart';
import 'package:reqbot/database/database_helper.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecordController {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool isListening = false;
  String transcription = '';

  // API URL for extracting requirements
  final String apiUrl = 'http://192.168.1.2:5000/extract';

  Future<void> startListening(Function(String) onTranscriptionUpdated) async {
    try {
      var status = await Permission.microphone.request();

      if (status.isGranted) {
        bool available = await _speech.initialize(
          onStatus: (status) => print('Speech status: $status'),
          onError: (error) => print('Speech error: $error'),
        );

        if (available) {
          isListening = true;
          _speech.listen(
            onResult: (result) {
              transcription = result.recognizedWords;
              onTranscriptionUpdated(transcription);
            },
          );
        } else {
          throw Exception('Speech recognition unavailable.');
        }
      } else if (status.isDenied) {
        throw Exception('Microphone permission is required.');
      } else if (status.isPermanentlyDenied) {
        throw Exception(
            'Microphone permission is permanently denied. Please enable it in settings.');
      }
    } catch (e) {
      throw Exception('Error initializing speech-to-text: $e');
    }
  }

  Future<void> stopListening() async {
    await _speech.stop();
    isListening = false;
  }

  Future<void> saveProject(String projectName, String transcription) async {
    if (projectName.isEmpty || transcription.isEmpty) {
      throw Exception('Please enter a project name and record audio.');
    }
    try {
      await DBHelper.instance.insertProject(projectName, transcription);
    } catch (e) {
      throw Exception('Error saving project: $e');
    }
  }

  // New method to send transcription to Flask API and fetch requirements
  Future<List<String>> fetchRequirements(String transcription) async {
    if (transcription.isEmpty) {
      throw Exception('Transcription is empty. Please record audio first.');
    }
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"transcription": transcription}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return List<String>.from(data['requirements']);
      } else {
        throw Exception('Failed to fetch requirements: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error connecting to API: $e');
    }
  }

  // New method to check permissions and initialize speech-to-text
  Future<void> initializeSpeechRecognition() async {
    try {
      final status = await Permission.microphone.request();
      if (status.isGranted) {
        bool available = await _speech.initialize(
          onStatus: (status) => print('Speech status: $status'),
          onError: (error) => print('Speech error: $error'),
        );
        if (!available) {
          throw Exception('Speech recognition is not available.');
        }
      } else {
        throw Exception(
            'Microphone permission is required to use speech-to-text features.');
      }
    } catch (e) {
      throw Exception('Failed to initialize speech recognition: $e');
    }
  }

  // New method to clear transcription
  void clearTranscription() {
    transcription = '';
  }
}
