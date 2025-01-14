import 'package:flutter/material.dart';
import 'package:reqbot/controllers/record_controller.dart';
import '../widgets/project_name_input_field.dart';
import '../widgets/transcription_display.dart';
import 'home_screen.dart';
import 'structured_requirements.dart'; // Import the screen for displaying requirements

class Record extends StatefulWidget {
  const Record({super.key});

  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Record> {
  final RecordController _controller = RecordController();
  final TextEditingController _projectNameController = TextEditingController();
  String _transcription = '';
  bool _isListening = false;

  void _updateTranscription(String transcription) {
    setState(() {
      _transcription = transcription;
    });
  }

  Future<void> _handleStartStopRecording() async {
    try {
      if (_isListening) {
        await _controller.stopListening();
      } else {
        await _controller.startListening(_updateTranscription);
      }
      setState(() {
        _isListening = _controller.isListening;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> _handleSaveProject() async {
    try {
      await _controller.saveProject(_projectNameController.text, _transcription);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Project saved successfully.')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future<void> _handleExtractRequirements() async {
    try {
      // Fetch requirements from the controller
      final requirements = await _controller.fetchRequirements(_transcription);

      // Navigate to the Structured Requirements screen with the fetched requirements
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StructuredRequirementsScreen(requirements: requirements),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
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
      body: SingleChildScrollView( // Wrap the content in a SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProjectNameInputField(controller: _projectNameController),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _handleStartStopRecording,
                child: Text(_isListening ? 'Stop Recording' : 'Start Recording'),
              ),
              const SizedBox(height: 16),
              if (_transcription.isNotEmpty)
                TranscriptionDisplay(transcription: _transcription),
              const SizedBox(height: 16), // Add extra spacing
              ElevatedButton(
                onPressed: _handleSaveProject,
                child: const Text('Save Project'),
              ),
              const SizedBox(height: 16), // Add extra spacing
              if (_transcription.isNotEmpty) // Show Extract Requirements button if transcription is not empty
                ElevatedButton(
                  onPressed: _handleExtractRequirements,
                  child: const Text('Extract Requirements'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
