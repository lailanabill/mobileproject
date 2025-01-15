import 'package:flutter/material.dart';
import 'package:reqbot/services/auth/auth_services.dart';

// The SignInController handles user sign-in logic, including form validation, authentication, and navigation.
class SignInController {
  final AuthServices authServices = AuthServices(); // Handles communication with authentication services.
  final TextEditingController emailController = TextEditingController(); // Controller for email input field.
  final TextEditingController passwordController = TextEditingController(); // Controller for password input field.

  // Validates the email input from the user.
  // Ensures the input is not empty and matches a valid email format.
  // Returns an error message string if invalid, or null if valid.
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email or Phone number is required';
    }
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // Validates the password input from the user.
  // Ensures the input is not empty.
  // Returns an error message string if invalid, or null if valid.
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  // Attempts to log the user in using the provided email and password.
  //
  // Parameters:
  // - context: The BuildContext for navigating to the home screen and showing messages.
  //
  // Process:
  // 1. Retrieves email and password values from their respective controllers.
  // 2. Uses AuthServices to attempt sign-in with the provided credentials.
  // 3. On success:
  //    - Checks if a valid session exists.
  //    - Navigates to the HomeScreen.
  // 4. On failure:
  //    - Displays a SnackBar with an error message.
  Future<void> login(BuildContext context) async {
    final email = emailController.text; // Get the entered email.
    final password = passwordController.text; // Get the entered password.

    try {
      // Attempt sign-in using the provided email and password.
      final response = await authServices.signInWithEmailPassword(email, password);

      if (response.session != null) {
        // If a valid session is found, navigate to the home screen.
        Navigator.pushReplacementNamed(context, '/HomeScreen');
      } else {
        // Show an error message if no session is found.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: No session found")),
        );
      }
    } catch (e) {
      // Handle any errors during the login process.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Error: $e")),
      );
    }
  }
}
