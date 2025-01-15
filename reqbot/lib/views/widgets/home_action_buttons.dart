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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildActionButton(
            label: 'New Project',
            icon: Icons.create_new_folder_outlined,
            onPressed: onNewProject,
          ),
          const SizedBox(height: 12), // Reduced gap
          _buildActionButton(
            label: 'View Favorites',
            icon: Icons.favorite_border,
            onPressed: onViewFavorites,
          ),
          const SizedBox(height: 12), // Reduced gap
          _buildActionButton(
            label: 'Reqbot Chat',
            icon: Icons.chat_bubble_outline,
            onPressed: onGoToChatPage,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.2),
        backgroundColor: Colors.transparent,
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF3F51B5), Color(0xFF7986CB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(
            minWidth: 200,
            minHeight: 50, // Slightly reduced height
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
