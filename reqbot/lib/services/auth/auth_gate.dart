import 'package:flutter/material.dart';
import 'package:reqbot/views/screens/home_screen.dart';
import 'package:reqbot/views/screens/sign_in_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// AuthGate acts as an entry point to handle user authentication state.
// It listens for changes in authentication status and navigates users
// to either the HomeScreen or SignInPage based on their session state.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // Listens to authentication state changes from Supabase.
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        // While waiting for the authentication state to initialize, show a loading indicator.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(), // Displays a loading spinner.
            ),
          );
        }

        // Retrieves the session object from the snapshot if available.
        final session = snapshot.hasData ? snapshot.data!.session : null;

        // If a valid session exists, navigate to the HomeScreen.
        if (session != null) {
          return const HomeScreen();
        } else {
          // If no session is found, navigate to the SignInPage.
          return const SignInPage();
        }
      },
    );
  }
}
