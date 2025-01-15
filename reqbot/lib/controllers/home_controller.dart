import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:reqbot/models/project_model.dart';
import 'package:reqbot/database/database_helper.dart';

class HomeController {
  final DBHelper _dbHelper = DBHelper.instance;

  Future<List<ProjectModel>> loadProjects() async {
    final data = await _dbHelper.getProjects();
    return data.map((e) => ProjectModel.fromMap(e)).toList();
  }

  Future<void> addProject(String name, String transcription) async {
    await _dbHelper.insertProject(name, transcription);
  }

  Future<void> removeProject(int id) async {
    await _dbHelper.deleteProject(id);
  }

  // Fetch requirements from API
  Future<List<String>> fetchRequirements(String transcription) async {
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
}
