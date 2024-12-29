import 'package:flutter/material.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final String projectName;
  final String transcription;

  const ProjectDetailsScreen({
    super.key,
    required this.projectName,
    required this.transcription,
  });

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
            const Text(
              'Transcription:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              transcription,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}