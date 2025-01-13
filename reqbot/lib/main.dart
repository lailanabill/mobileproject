import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import '/services/gemini_service.dart';
import '/views/themes/light_theme.dart';
import '/views/themes/dark_theme.dart';
import '/views/widgets/app_initialization.dart';
import '/services/providers/favorites_provider.dart';
import '/views/widgets/app_routes.dart';

void main() async {
  await initializeApp(); // Initialization logic moved to a helper
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FavoritesProvider(),
        ),
      ],
      child: const ReqBotApp(),
    ),
  );
}

class ReqBotApp extends StatelessWidget {
  const ReqBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    final geminiService = GeminiService(apiKey: apiKey);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReqBot',
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: AppRoutes.getRoutes(geminiService), // Pass geminiService to routes
    );
  }
}
