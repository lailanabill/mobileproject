import 'package:flutter/material.dart';
import 'package:reqbot/database/database_helper.dart';

class ProjectNameScreen extends StatefulWidget {
  const ProjectNameScreen({super.key});

  @override
  _ProjectNameScreenState createState() => _ProjectNameScreenState();
}

class _ProjectNameScreenState extends State<ProjectNameScreen> {
  final TextEditingController _projectNameController = TextEditingController();

  Future<void> _saveProject() async {
    if (_projectNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a project name.')),
      );
      return;
    }

    try {
      await DBHelper.instance.insertProject(
        _projectNameController.text,
        'in_progress', // Default status
      );

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Project saved successfully.')));

      Navigator.pop(context);
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
        title: const Text('New Project'),
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
