// Import necessary packages for functionality
import 'package:permission_handler/permission_handler.dart'; // For handling microphone permissions
import 'package:reqbot/database/database_helper.dart'; // For interacting with a database
import 'package:speech_to_text/speech_to_text.dart' as stt; // For speech-to-text conversion
import 'package:http/http.dart' as http; // For sending HTTP requests to an API
import 'dart:convert'; // For encoding/decoding JSON data

// Controller class to manage speech-to-text, database, and API interactions
class RecordController {
  // Speech-to-text instance for managing speech recognition
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool isListening = false; // To track if the app is actively listening
  String transcription = ''; // Stores the recognized speech as text

  // API URL for sending transcription to extract requirements
  final String apiUrl = 'http://192.168.1.2:5000/extract';

  // Helper method to ensure microphone permissions and initialize speech-to-text
  Future<void> _ensureSpeechRecognitionReady() async {
    // Request microphone permission
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      throw Exception('Microphone permission is required.');
    }

    // Initialize the speech-to-text functionality
    bool available = await _speech.initialize(
      onStatus: (status) => print('Speech status: $status'), // Log status
      onError: (error) => print('Speech error: $error'), // Log errors
    );

    // Check if initialization was successful
    if (!available) {
      throw Exception('Speech recognition is not available.');
    }
  }

  // Method to start listening for speech and update transcription
  Future<void> startListening(Function(String) onTranscriptionUpdated) async {
    try {
      // Ensure speech recognition is ready
      await _ensureSpeechRecognitionReady();

      isListening = true; // Set listening flag to true
      _speech.listen(
        onResult: (result) {
          transcription = result.recognizedWords; // Update transcription
          onTranscriptionUpdated(transcription); // Notify listener of changes
        },
      );
    } catch (e) {
      throw Exception('Error starting listening: $e');
    }
  }

  // Method to stop listening for speech
  Future<void> stopListening() async {
    await _speech.stop(); // Stop speech recognition
    isListening = false; // Set listening flag to false
  }

  // Method to save project name and transcription to the database
  Future<void> saveProject(String projectName, String transcription) async {
    if (projectName.isEmpty || transcription.isEmpty) {
      throw Exception('Please enter a project name and record audio.'); // Validate inputs
    }
    try {
      // Insert project data into the database
      await DBHelper.instance.insertProject(projectName, transcription);
    } catch (e) {
      throw Exception('Error saving project: $e');
    }
  }

  // Method to send transcription to Flask API and retrieve requirements
  Future<List<String>> fetchRequirements(String transcription) async {
    if (transcription.isEmpty) { // Validate transcription
      throw Exception('Transcription is empty. Please record audio first.');
    }
    try {
      // Send POST request to the Flask API
      final response = await http.post(
        Uri.parse(apiUrl), // API endpoint
        headers: {"Content-Type": "application/json"}, // Set content type as JSON
        body: jsonEncode({"transcription": transcription}), // Send transcription as JSON body
      );

      if (response.statusCode == 200) { // If API returns a successful response
        final data = jsonDecode(response.body); // Decode JSON response
        return List<String>.from(data['requirements']); // Extract and return requirements list
      } else {
        throw Exception('Failed to fetch requirements: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error connecting to API: $e');
    }
  }

  // Method to clear the transcription text
  void clearTranscription() {
    transcription = ''; // Reset transcription to an empty string
  }
}
