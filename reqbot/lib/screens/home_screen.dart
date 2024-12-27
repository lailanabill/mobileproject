import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../database/database_helper.dart'; // Import the database helper
import 'package:reqbot/screens/project_name_input_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _projects = [];

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    try {
      final projects = await _dbHelper.getProjects() ?? [];
      setState(() {
        _projects = projects;
      });
    } catch (e) {
      // Handle error (e.g., show an alert or log)
      print('Error loading projects: $e');
    }
  }

  Future<void> _deleteProject(int id) async {
    await _dbHelper.deleteProject(id);
    _loadProjects(); // Refresh the project list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3F51B5), Color(0xFFF6F7FB)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Recent Projects',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: _projects.isEmpty
                        ? Center(
                            child: Text('No projects available',
                                style: TextStyle(color: Colors.white)))
                        : ListView.builder(
                            itemCount: _projects.length,
                            itemBuilder: (context, index) {
                              final projectName = _projects[index]['name'];
                              final projectStatus = _projects[index]['status'];
                              final projectId = _projects[index]['id'];

                              return Slidable(
                                key: ValueKey(projectId),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        _deleteProject(projectId);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text('$projectName deleted'),
                                          ),
                                        );
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: Card(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: ListTile(
                                    title: Text(projectName),
                                    subtitle: Text(projectStatus),
                                    onTap: () {
                                      // You can add functionality for when a project is tapped
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProjectNameInputScreen(),
                        ),
                      ).then((_) => _loadProjects()); // Refresh projects
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Add New Project',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
