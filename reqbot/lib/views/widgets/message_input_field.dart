import 'package:flutter/material.dart';
import 'package:reqbot/controllers/chat_controller.dart';

/// MessageInputField handles user input and sends messages via the ChatController.
///
/// Parameters:
/// - [controller]: The ChatController to manage message sending.
class MessageInputField extends StatelessWidget {
  final ChatController controller; // ChatController instance for managing chat logic.

  const MessageInputField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController(); // Controller for input text.

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 4,
            color: Colors.black12,
          ),
        ],
      ),
      child: Row(
        children: [
          // TextField for user input.
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // FloatingActionButton for sending the message.
          FloatingActionButton(
            onPressed: () {
              final message = messageController.text.trim();
              if (message.isNotEmpty) {
                messageController.clear();
                controller.sendMessage(message); // Calls sendMessage from ChatController.
              }
            },
            child: const Icon(Icons.send),
            mini: true,
          ),
        ],
      ),
    );
  }
}
