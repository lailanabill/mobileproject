import 'package:flutter/material.dart';

class StructuredRequirementsScreen extends StatelessWidget {
  final List<String> requirements;

  // Accepting dynamic requirements as input
  const StructuredRequirementsScreen({super.key, required this.requirements});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Requirements'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check the screen width and build different layouts based on the constraints
          if (constraints.maxWidth > 600) {
            // If the screen width is larger than 600, show a more spacious layout
            return _buildWideLayout(context);
          } else {
            // For smaller screens, show a compact layout
            return _buildNarrowLayout(context);
          }
        },
      ),
    );
  }

  // Wide layout (for larger screens)
  Widget _buildWideLayout(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Structured Requirements",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Requirements List",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: _buildRequirementsList(context),
        ),
      ],
    );
  }

  // Narrow layout (for smaller screens)
  Widget _buildNarrowLayout(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Structured Requirements",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Requirements List",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: _buildRequirementsList(context),
        ),
      ],
    );
  }

  // Build the requirements list dynamically
  Widget _buildRequirementsList(BuildContext context) {
    return requirements.isEmpty
        ? Center(
            child: Text(
              "No requirements available.",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: requirements.length,
            itemBuilder: (context, index) {
              return _buildTaskItem(
                context,
                iconColor: Colors.blue,
                title: requirements[index],
                status: "Pending", // Default status for each requirement
                statusColor: Colors.red, // Default color for pending status
              );
            },
          );
  }

  Widget _buildTaskItem(BuildContext context,
      {required Color iconColor,
      required String title,
      required String status,
      required Color statusColor}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.folder, color: iconColor, size: 28),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
          Text(
            status,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: statusColor),
          ),
        ],
      ),
    );
  }
}
