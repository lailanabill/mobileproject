import 'package:flutter/material.dart';
import 'package:reqbot/services/gemini_service.dart';

/// ChatController handles chat logic and state using ValueNotifier.
class ChatController {
  final GeminiService geminiService;

  // ValueNotifier to track the loading state.
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  // ValueNotifier to track the list of messages.
  final ValueNotifier<List<Map<String, dynamic>>> messages = ValueNotifier([]);

  ChatController({required this.geminiService});

  /// Sends a message to the GeminiService and updates the chat state.
  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    // Add the user's message to the chat and notify listeners.
    messages.value = [...messages.value, {'message': message, 'isUser': true}];
    isLoading.value = true;

    try {
      // Send the message and get the response from GeminiService.
      final response = await geminiService.sendMessage(message);
      messages.value = [...messages.value, {'message': response, 'isUser': false}];
    } catch (e) {
      // Handle errors by adding an error message to the chat.
      messages.value = [...messages.value, {'message': 'Error: $e', 'isUser': false}];
    } finally {
      isLoading.value = false;
    }
  }
}
