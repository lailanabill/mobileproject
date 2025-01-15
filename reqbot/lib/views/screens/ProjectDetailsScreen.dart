import 'package:flutter/material.dart';
import '../widgets/transcription_display.dart';
import '../screens/structured_requirements.dart'; // Import for requirements screen
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProjectDetailsScreen extends StatelessWidget {
  final String projectName;
  final String transcription;

  const ProjectDetailsScreen({
    super.key,
    required this.projectName,
    required this.transcription,
  });

  Future<List<String>> _fetchRequirements(String transcription) async {
    const String apiUrl = 'http://192.168.1.2:5000/extract'; // Replace with your API URL

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
      throw Exception('Error connecting to the API: $e');
    }
  }

  void _navigateToRequirements(BuildContext context) async {
    try {
      final requirements = await _fetchRequirements(transcription);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StructuredRequirementsScreen(
            requirements: requirements,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching requirements: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(projectName),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TranscriptionDisplay(transcription: transcription),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigateToRequirements(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              child: const Text(
                'View Requirements',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
