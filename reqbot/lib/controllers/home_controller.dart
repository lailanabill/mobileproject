import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:reqbot/models/project_model.dart';
import 'package:reqbot/database/database_helper.dart';

// HomeController serves as the main controller for managing projects and interacting with the API.
// It handles operations such as loading projects from the database, adding or removing projects,
// and fetching requirements from an external API.
class HomeController {
  final DBHelper _dbHelper = DBHelper.instance;

  // Loads all projects from the database.
  // This method retrieves project data from the local database using DBHelper,
  // then converts the raw data into a list of ProjectModel objects.
  Future<List<ProjectModel>> loadProjects() async {
    final data = await _dbHelper.getProjects();
    return data.map((e) => ProjectModel.fromMap(e)).toList();
  }

  // Adds a new project to the database.
  // Takes the project name and its transcription as input and inserts them into the database.
  Future<void> addProject(String name, String transcription) async {
    await _dbHelper.insertProject(name, transcription);
  }

  // Removes a project from the database based on its ID.
  // This method is used for deleting a project record from the local database.
  Future<void> removeProject(int id) async {
    await _dbHelper.deleteProject(id);
  }

  // Fetches a list of requirements from an external API.
  // Sends a POST request to the specified API endpoint with a transcription payload,
  // expecting the response to include a list of extracted requirements.
  //
  // Parameters:
  // - transcription: The input string to be processed by the API.
  //
  // Returns:
  // - A list of requirements (List<String>) extracted from the transcription.
  Future<List<String>> fetchRequirements(String transcription) async {
    const String apiUrl = 'http://172.20.10.6:5000/extract'; // Replace with your API URL
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
        // Handles HTTP errors, returning the response body for debugging purposes.
        throw Exception('Failed to fetch requirements: ${response.body}');
      }
    } catch (e) {
      // Catches and throws exceptions for network or other API-related issues.
      throw Exception('Error connecting to the API: $e');
    }
  }
}
