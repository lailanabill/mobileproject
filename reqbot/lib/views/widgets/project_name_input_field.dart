import 'package:flutter/material.dart';

class ProjectNameInputField extends StatelessWidget {
  final TextEditingController controller;

  const ProjectNameInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Project Name',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter project name',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
