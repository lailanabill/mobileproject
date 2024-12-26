import 'package:flutter/material.dart';
import 'package:reqbot/screens/record.dart';
import 'upload_convert.dart';

class ProjectNameInputScreen extends StatelessWidget {
  const ProjectNameInputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController projectNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Project'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check the screen width and adjust layout accordingly
          if (constraints.maxWidth > 600) {
            // For wider screens, use the wide layout
            return _buildWideLayout(context, projectNameController);
          } else {
            // For narrower screens, use the compact layout
            return _buildNarrowLayout(context, projectNameController);
          }
        },
      ),
    );
  }

  // Wide layout (for larger screens)
  Widget _buildWideLayout(BuildContext context, TextEditingController projectNameController) {
    return Stack(
      children: [
        // Background Gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3F51B5), Color(0xFFF6F7FB)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(32.0), // Larger padding for wider screens
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated TextField
              _buildAnimatedTextField(projectNameController),

              const SizedBox(height: 24),

              // Animated Buttons
              _buildAnimatedButton(
                label: 'Upload Audio',
                icon: Icons.audiotrack,
                onPressed: () => _handleUploadAudio(context, projectNameController),
              ),
              const SizedBox(height: 16),
              _buildAnimatedButton(
                label: 'Upload Text',
                icon: Icons.text_fields,
                onPressed: () {
                  // Implement text upload functionality
                },
              ),
              const SizedBox(height: 16),
              _buildAnimatedButton(
                label: 'Start Recording',
                icon: Icons.mic,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Record()),
                ),
              ),

              const Spacer(),

              // Animated Navigation Buttons
              _buildNavigationButtons(context, projectNameController),
            ],
          ),
        ),
      ],
    );
  }

  // Narrow layout (for smaller screens)
  Widget _buildNarrowLayout(BuildContext context, TextEditingController projectNameController) {
    return Stack(
      children: [
        // Background Gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3F51B5), Color(0xFFF6F7FB)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0), // Smaller padding for narrower screens
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated TextField
              _buildAnimatedTextField(projectNameController),

              const SizedBox(height: 16),

              // Animated Buttons
              _buildAnimatedButton(
                label: 'Upload Audio',
                icon: Icons.audiotrack,
                onPressed: () => _handleUploadAudio(context, projectNameController),
              ),
              const SizedBox(height: 12),
              _buildAnimatedButton(
                label: 'Upload Text',
                icon: Icons.text_fields,
                onPressed: () {
                  // Implement text upload functionality
                },
              ),
              const SizedBox(height: 12),
              _buildAnimatedButton(
                label: 'Start Recording',
                icon: Icons.mic,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Record()),
                ),
              ),

              const Spacer(),

              // Animated Navigation Buttons
              _buildNavigationButtons(context, projectNameController),
            ],
          ),
        ),
      ],
    );
  }

  // Animated TextField
  Widget _buildAnimatedTextField(TextEditingController projectNameController) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 700),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double opacity, child) {
        return Opacity(
          opacity: opacity,
          child: child,
        );
      },
      child: TextField(
        controller: projectNameController,
        decoration: InputDecoration(
          labelText: 'Project Name',
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }

  // Animated Buttons
  Widget _buildAnimatedButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double scale, child) {
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: UploadButton(
        label: label,
        icon: icon,
        color: Colors.blueAccent,
        onPressed: onPressed,
      ),
    );
  }

  // Handle Upload Audio button click
  void _handleUploadAudio(BuildContext context, TextEditingController projectNameController) {
    if (projectNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a project name.')),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UploadConvertScreen()),
      );
    }
  }

  // Navigation Buttons (Back & Continue)
  Widget _buildNavigationButtons(BuildContext context, TextEditingController projectNameController) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 800),
      tween: Tween<Offset>(begin: const Offset(0, 0.5), end: const Offset(0, 0)),
      curve: Curves.easeOut,
      builder: (context, Offset offset, child) {
        return Transform.translate(
          offset: offset,
          child: child,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Back',
              style: TextStyle(color: Colors.white), // White text
            ),
          ),
          ElevatedButton(
            onPressed: () => _handleUploadAudio(context, projectNameController),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Continue',
              style: TextStyle(color: Colors.white), // White text
            ),
          ),
        ],
      ),
    );
  }
}

// Updated UploadButton with Icon and Colors
class UploadButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const UploadButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      splashColor: color.withOpacity(0.3),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
