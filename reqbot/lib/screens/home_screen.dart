import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqbot/services/auth/auth_services.dart';
import 'package:reqbot/providers/favorites_provider.dart';
import 'package:reqbot/screens/project_name_input_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final AuthServices authServices = AuthServices();

  List<String> projectNames = ['Project X', 'Project Y', 'Project Z'];
  List<String> projectStatuses = [
    'completed',
    'attention_needed',
    'in_progress'
  ];

  String? lastRemovedProject;
  String? lastRemovedStatus;
  int? lastRemovedIndex;

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

 
    // S
    


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
                          CircleAvatar(
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
                    child: ListView.builder(
                      itemCount: projectNames.length,
                      itemBuilder: (context, index) {
                        return AnimatedProjectCard(
                          projectName: projectNames[index],
                          status: projectStatuses[index],
                         
                        );
                      },
                    ),
                  ),

                  // Notifications Section
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
                            message: 'Feedback requested on Project x'),
                        SizedBox(height: 10),
                        NotificationButton(
                            message: 'Validation issue detected in Project y'),
                      ],
                    ),
                  ),

                  // Bottom Section - Buttons
                  const SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ProjectNameInputScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: Color(0xFF3F51B5),
                            ),
                          ),
                          child: const Text(
                            'New Project',
                            style: TextStyle(color: Color(0xFF3F51B5)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/FavoritesScreen');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                          ),
                          child: const Text(
                            'View Favorites',
                            style: TextStyle(color: Color(0xFF3F51B5)),
                          ),
                        ),
                      ],
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

class AnimatedProjectCard extends StatelessWidget {
  final String projectName;
  final String status;
  final VoidCallback onRemove;

  const AnimatedProjectCard({
    required this.projectName,
    required this.status,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isFavorite = favoritesProvider.isFavorite(projectName);

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0.8, end: 1),
      curve: Curves.easeOut,
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: Dismissible(
            key: ValueKey(projectName),
            background: Container(color: Colors.red),
            onDismissed: (_) => onRemove(),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Text(projectName),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      status == 'completed'
                          ? Icons.check_circle
                          : status == 'attention_needed'
                              ? Icons.error
                              : Icons.access_time,
                      color: status == 'completed'
                          ? Colors.green
                          : status == 'attention_needed'
                              ? Colors.red
                              : Colors.orange,
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        favoritesProvider.toggleFavorite(projectName);
                        final snackBarMessage = isFavorite
                            ? '$projectName removed from favorites'
                            : '$projectName added to favorites';
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(snackBarMessage)),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class NotificationButton extends StatelessWidget {
  final String message;

  const NotificationButton({required this.message});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$message tapped')),
        );
      },
      splashColor: Colors.blue.withOpacity(0.2),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.notifications, color: Color(0xFF3F51B5)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
