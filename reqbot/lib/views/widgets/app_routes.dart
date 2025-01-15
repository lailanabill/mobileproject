import 'package:flutter/material.dart';
import 'package:reqbot/controllers/chat_controller.dart';
import 'package:reqbot/views/screens/chatScreen.dart';
import '/views/screens/record.dart';
import '/views/screens/sign_in_page.dart';
import '/views/screens/sign_up_page.dart';
import '/views/screens/welcome_page.dart';
import '/views/screens/home_screen.dart';
import '/views/screens/favorites_screen.dart';
import '/services/gemini_service.dart';

class AppRoutes {
  /// Returns a map of routes for the app.
  ///
  /// [geminiService] is the dependency required by the ChatController, which is passed to ChatScreen.
  static Map<String, WidgetBuilder> getRoutes(GeminiService geminiService) {
    return {
      '/': (context) => WelcomePage(),
      '/sign-in': (context) => SignInPage(),
      '/sign-up': (context) => SignUpPage(),
      '/HomeScreen': (context) => HomeScreen(),
      '/record': (context) => Record(),
      '/FavoritesScreen': (context) => FavoritesScreen(),
      '/ChatScreen': (context) {
        // Create a ChatController and pass it to ChatScreen.
        final chatController = ChatController(geminiService: geminiService);
        return ChatScreen(controller: chatController);
      },
    };
  }
}
