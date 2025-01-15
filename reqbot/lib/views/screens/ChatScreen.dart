import 'package:flutter/material.dart';
import 'package:reqbot/controllers/chat_controller.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input_field.dart';

/// ChatScreen displays the user interface for interacting with the chatbot.
/// It uses ChatController to manage state and handle user actions.
class ChatScreen extends StatelessWidget {
  final ChatController controller;

  const ChatScreen({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reqbot AI Chat'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Display the chat messages in a scrollable ListView.
          Expanded(
            child: ValueListenableBuilder<List<Map<String, dynamic>>>(
              valueListenable: controller.messages,
              builder: (context, messages, _) {
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return MessageBubble(
                      message: message['message'],
                      isUser: message['isUser'],
                    );
                  },
                );
              },
            ),
          ),
          // Show a loading indicator when a message is being processed.
          ValueListenableBuilder<bool>(
            valueListenable: controller.isLoading,
            builder: (context, isLoading, _) {
              return isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox.shrink();
            },
          ),
          // Input field and send button for user interaction.
          MessageInputField(controller: controller),
        ],
      ),
    );
  }
}
