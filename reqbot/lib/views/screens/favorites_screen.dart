import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/providers/favorites_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favoriteProjects = favoritesProvider.favoriteProjects.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Projects'),
        backgroundColor: const Color(0xFF3F51B5),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check if there are any favorite projects
          if (favoriteProjects.isEmpty) {
            return const Center(
              child: Text(
                'No favorite projects yet!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          // If there are favorite projects, show them in a ListView
          return ListView.builder(
            itemCount: favoriteProjects.length,
            itemBuilder: (context, index) {
              final projectName = favoriteProjects[index];

              // Calculate the text size based on available space
              double textSize = constraints.maxWidth * 0.05;

              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ListTile(
                  title: Text(
                    projectName,
                    style: TextStyle(fontSize: textSize), // Adjust text size
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Remove from favorites
                      favoritesProvider.toggleFavorite(projectName);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$projectName removed from favorites'),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}