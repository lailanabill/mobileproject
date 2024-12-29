import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reqbot/database/database_helper.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'home_screen.dart';

class Record extends StatefulWidget {
  const Record({super.key});

  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Record> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _transcription = '';
  final TextEditingController _projectNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  
Future<void> _startListening() async {
  try {
    var status = await Permission.microphone.request();

    if (status.isGranted) {
      // Permission is granted
      bool available = await _speech.initialize(
        onStatus: (status) => print('Speech status: $status'),
        onError: (error) => print('Speech error: $error'),
      );

      if (available) {
        setState(() {
          _isListening = true;
        });

        _speech.listen(
          onResult: (result) {
            setState(() {
              _transcription = result.recognizedWords;
            });
          },
        );
      } else {
        setState(() {
          _isListening = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Speech recognition unavailable.')),
        );
      }
    } else if (status.isDenied) {
      // Permission is denied
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Microphone permission is required.'),
        ),
      );
    } else if (status.isPermanentlyDenied) {
      // Permission is permanently denied, redirect to settings
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'Microphone permission is permanently denied. Please enable it in settings.'),
          action: SnackBarAction(
            label: 'Open Settings',
            onPressed: openAppSettings, // Redirect to settings
          ),
        ),
      );
    }
  } catch (e) {
    print('Error initializing speech-to-text: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error initializing speech-to-text: $e')),
    );
  }
}


  Future<void> _stopListening() async {
    await _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  Future<void> _saveProject() async {
    if (_projectNameController.text.isEmpty || _transcription.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter a project name and record audio.')),
      );
      return;
    }

    try {
      // Save project to database
      await DBHelper.instance.insertProject(
        _projectNameController.text,
        _transcription,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Project saved successfully.')),
      );

      // Navigate back to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      print('Error saving project: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving project: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Project Name',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _projectNameController,
              decoration: const InputDecoration(
                hintText: 'Enter project name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (_isListening) {
                  await _stopListening();
                } else {
                  await _startListening();
                }
              },
              child: Text(_isListening ? 'Stop Recording' : 'Start Recording'),
            ),
            const SizedBox(height: 16),
            if (_transcription.isNotEmpty)
              Text(
                'Transcription: $_transcription',
                style: const TextStyle(fontSize: 16),
              ),
            const Spacer(),
            ElevatedButton(
              onPressed: _saveProject,
              child: const Text('Save Project'),
            ),
          ],
        ),
      ),
    );
  }
}