import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // For state management
import 'package:reqbot/providers/favorites_provider.dart'; // Import FavoritesProvider
import 'screens/record.dart';
import 'screens/sign_in_page.dart';
import 'screens/sign_up_page.dart';
import 'screens/upload_convert.dart';
import 'screens/welcome_page.dart';
import 'screens/home_screen.dart';
import 'screens/favorites_screen.dart'; // Import FavoritesScreen

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FavoritesProvider(), // Register FavoritesProvider
        ),
      ],
      child: const ReqBotApp(),
    ),
  );
}

class ReqBotApp extends StatelessWidget {
  const ReqBotApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ReqBot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        '/sign-in': (context) => SignInPage(),
        '/sign-up': (context) => SignUpPage(),
        '/HomeScreen': (context) => HomeScreen(),
        '/record': (context) => Record(),
        '/FavoritesScreen': (context) => FavoritesScreen(), // Add route for FavoritesScreen
      },
    );
  }
}