import 'package:flutter/material.dart';

class HomeActionButtons extends StatelessWidget {
  final VoidCallback onNewProject;
  final VoidCallback onViewFavorites;
  final VoidCallback onGoToChatPage;

  const HomeActionButtons({
    super.key,
    required this.onNewProject,
    required this.onViewFavorites,
    required this.onGoToChatPage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: onNewProject,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              textStyle: const TextStyle(
                fontSize: 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              'New Project',
              style: TextStyle(color: Color(0xFF3F51B5)),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onViewFavorites,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              textStyle: const TextStyle(
                fontSize: 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              'View Favorites',
              style: TextStyle(color: Color(0xFF3F51B5)),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onGoToChatPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              textStyle: const TextStyle(
                fontSize: 20,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              'Reqbot Chat',
              style: TextStyle(color: Color(0xFF3F51B5)),
            ),
          ),
        ],
      ),
    );
  }
}
