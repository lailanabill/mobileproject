import 'package:flutter/material.dart';
import 'package:reqbot/controllers/home_controller.dart';
import 'package:reqbot/models/project_model.dart';
import 'package:reqbot/services/gemini_service.dart';
import '../widgets/home_header.dart';
import '../widgets/home_action_buttons.dart';
import '../widgets/animated_project_card.dart';
import '../screens/projectDetailsScreen.dart';
import '../screens/record.dart';
import '../screens/structured_requirements.dart'; // Added import for requirements screen
import 'package:reqbot/services/auth/auth_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = HomeController();
  final AuthServices _authServices = AuthServices();
  List<ProjectModel> _projects = [];
  ProjectModel? _lastRemovedProject;
  int? _lastRemovedProjectIndex;

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    final projects = await _controller.loadProjects();
    setState(() {
      _projects = projects;
    });
  }

  Future<void> _removeProject(int index) async {
    _lastRemovedProject = _projects[index];
    _lastRemovedProjectIndex = index;

    setState(() {
      _projects.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_lastRemovedProject!.name} removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            if (_lastRemovedProject != null &&
                _lastRemovedProjectIndex != null) {
              setState(() {
                _projects.insert(
                    _lastRemovedProjectIndex!, _lastRemovedProject!);
              });
              _lastRemovedProject = null;
              _lastRemovedProjectIndex = null;
            }
          },
        ),
      ),
    );

    // Proceed with actual deletion in the backend only if the action isn't undone
    await Future.delayed(const Duration(seconds: 5), () async {
      if (_lastRemovedProject != null) {
        await _controller.removeProject(_lastRemovedProject!.id);
        _lastRemovedProject = null;
        _lastRemovedProjectIndex = null;
      }
    });
  }

  void _logout() async {
    try {
      await _authServices.signOut();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/sign-in',
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error during logout: $e")),
      );
    }
  }

  void _navigateToRequirements(String transcription) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StructuredRequirementsScreen(
          requirements: transcription.split('\n'), // Example logic
        ),
      ),
    );
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
                  HomeHeader(onLogout: _logout),
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
                    child: FutureBuilder<List<ProjectModel>>(
                      future: _controller.loadProjects(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Error: ${snapshot.error}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text(
                              'No recent projects.',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        final projects = snapshot.data!;
                        return ListView.builder(
                          itemCount: projects.length,
                          itemBuilder: (context, index) {
                            final project = projects[index];
                            return AnimatedProjectCard(
                              projectName: project.name,
                              transcription: project.transcription,
                              onRemove: () => _removeProject(index),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProjectDetailsScreen(
                                    projectName: project.name,
                                    transcription: project.transcription,
                                  ),
                                ),
                              ),
                              fetchRequirements: (transcription) async {
                                return await _controller.fetchRequirements(
                                    transcription); // Fetch from API
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  HomeActionButtons(
                    onNewProject: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Record(),
                      ),
                    ).then((_) => _loadProjects()),
                    onViewFavorites: () =>
                        Navigator.pushNamed(context, '/FavoritesScreen'),
                    onGoToChatPage: () => Navigator.pushNamed(
                      context,
                      '/ChatScreen',
                      arguments: GeminiService,
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
