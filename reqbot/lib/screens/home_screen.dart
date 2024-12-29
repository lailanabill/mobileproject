import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqbot/database/database_helper.dart';
import 'package:reqbot/screens/ProjectDetailsScreen.dart';
import 'package:reqbot/services/auth/auth_services.dart';
import 'package:reqbot/providers/favorites_provider.dart';
import 'record.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthServices authServices = AuthServices();
  List<Map<String, dynamic>> projects = [];
  String? lastRemovedProject;
  String? lastRemovedTranscription;
  int? lastRemovedId;

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    final data = await DBHelper.instance.getProjects();
    setState(() {
      projects = List<Map<String, dynamic>>.from(data);
    });
  }

  Future<void> removeProject(int index) async {
    lastRemovedProject = projects[index]['name'];
    lastRemovedTranscription = projects[index]['transcription'];
    lastRemovedId = projects[index]['id'];

    final removedProject = projects[index];
    setState(() {
      projects.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$lastRemovedProject removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () async {
            setState(() {
              projects.insert(index, removedProject);
            });
            await DBHelper.instance.insertProject(
              lastRemovedProject!,
              lastRemovedTranscription!,
            );
          },
        ),
        duration: const Duration(seconds: 4),
      ),
    );

    Future.delayed(const Duration(seconds: 4), () async {
      if (lastRemovedId != null) {
        await DBHelper.instance.deleteProject(lastRemovedId!);
        lastRemovedId = null;
      }
    });
  }

  void logout() async {
    try {
      await authServices.signOut();
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Home',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person, color: Color(0xFF3F51B5)),
                          ),
                          IconButton(
                            onPressed: logout,
                            icon: const Icon(Icons.logout, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
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
                    child: projects.isEmpty
                        ? const Center(
                            child: Text(
                              'No recent projects.',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : ListView.builder(
                            itemCount: projects.length,
                            itemBuilder: (context, index) {
                              final project = projects[index];
                              return AnimatedProjectCard(
                                projectName: project['name'],
                                onRemove: () => removeProject(index),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProjectDetailsScreen(
                                        projectName: project['name'],
                                        transcription: project['transcription'],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    flex: 1,
                    child: ListView(
                      children: const [
                        NotificationButton(
                            message: 'Feedback requested on Project X'),
                        SizedBox(height: 10),
                        NotificationButton(
                            message: 'Validation issue detected in Project Y'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [