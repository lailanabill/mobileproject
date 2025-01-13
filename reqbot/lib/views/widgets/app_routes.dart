import 'package:flutter/material.dart';
import 'package:reqbot/views/screens/ChatScreen.dart';
import '/views/screens/record.dart';
import '/views/screens/sign_in_page.dart';
import '/views/screens/sign_up_page.dart';
import '/views/screens/welcome_page.dart';
import '/views/screens/home_screen.dart';
import '/views/screens/favorites_screen.dart';
import '/services/gemini_service.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes(GeminiService geminiService) {
    return {
      '/': (context) => WelcomePage(),
      '/sign-in': (context) => SignInPage(),
      '/sign-up': (context) => SignUpPage(),
      '/HomeScreen': (context) => HomeScreen(),
      '/record': (context) => Record(),
      '/FavoritesScreen': (context) => FavoritesScreen(),
      '/ChatScreen': (context) =>
          ChatScreen(geminiService: geminiService), // Pass GeminiService
    };
  }
}
