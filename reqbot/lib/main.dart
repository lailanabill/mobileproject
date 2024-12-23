import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // For state management
import 'package:reqbotui/providers/favorites_provider.dart';
import 'screens/record.dart';
import 'screens/sign_in_page.dart';
import 'screens/sign_up_page.dart';
import 'screens/upload_convert.dart';
import 'screens/welcome_page.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => FavoritesProvider()), // Register FavoritesProvider
      ],
      child: const ReqBotApp(),
    ),
  );
}
