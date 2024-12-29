import 'package:flutter/material.dart';

class TranscriptionDisplay extends StatelessWidget {
  final String transcription;

  const TranscriptionDisplay({super.key, required this.transcription});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
