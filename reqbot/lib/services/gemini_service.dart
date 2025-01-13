//import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
//import 'package:http/http.dart' as http;
class GeminiService {
  final String apiKey;
  late final GenerativeModel model;
  late final ChatSession chat;

  GeminiService({required this.apiKey}) {
    model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey,
    );
    chat = model.startChat();
  }

  Future<String> sendMessage(String message) async {
    try {
      final response = await chat.sendMessage(Content.text(message));
      return response.text ?? 'Sorry, I could not generate a response';
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }
}