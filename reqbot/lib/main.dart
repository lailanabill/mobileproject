import 'package:flutter/material.dart';
import 'package:reqbot/screens/record.dart';
import 'package:reqbot/screens/sign_in_page.dart';
import 'package:reqbot/screens/sign_up_page.dart';
import 'package:reqbot/screens/upload_convert.dart';
import 'package:reqbot/screens/welcome_page.dart';
import 'package:reqbot/screens/home_screen.dart'; // Import the HomeScreen

void main() {
  runApp(const ReqBotApp());
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
        '/HomeScreen': (context) => HomeScreen(), // Add HomeScreen route
        '/record': (context) => Record(), // Add HomeScreen route
      },
    );
  }
}
