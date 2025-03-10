import 'package:flutter/material.dart';
import 'package:reqbot/services/auth/auth_services.dart';

// SignUpController manages the logic for the sign-up process,
// including form validation, handling user input, and interacting with the authentication service.
class SignUpController {
  final AuthServices authServices = AuthServices(); // Handles communication with authentication services.

  // Text controllers for capturing user input from the sign-up form.
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController positionController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Tracks whether the user has accepted the terms and conditions.
  final ValueNotifier<bool> isTermsAccepted = ValueNotifier(false);

  // Validates the user's full name input.
  String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Full Name is required';
    return null;
  }

  // Validates the user's email input.
  // Ensures the input is not empty and follows a valid email format.
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // Validates the user's phone number input.
  // Ensures the input is not empty and matches a valid phone number format (10-15 digits).
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Phone Number is required';
    if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  // Validates the user's password input.
  // Checks for minimum length, presence of uppercase, lowercase, digit, and special character.
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null; // Password is valid
  }

  // Handles the user sign-up process.
  //
  // Parameters:
  // - context: The BuildContext for displaying messages and navigation.
  //
  // Process:
  // 1. Checks if the terms and conditions checkbox is accepted.
  // 2. Retrieves user input values from the respective text controllers.
  // 3. Uses the AuthServices to attempt sign-up with the provided details.
  // 4. On success:
  //    - Displays a success message prompting email verification.
  //    - Navigates the user to the sign-in screen.
  // 5. On failure:
  //    - Displays an error message with the exception details.
  Future<void> signUp(BuildContext context) async {
    if (!isTermsAccepted.value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You must accept the terms and conditions.")),
      );
      return;
    }

    final name = nameController.text;
    final email = emailController.text;
    final phone = phoneController.text;
    final company = companyController.text;
    final position = positionController.text;
    final password = passwordController.text;

    try {
      final response = await authServices.signUpWithEmailPassword(
        name,
        email,
        phone,
        password,
        company,
        position,
      );
      if (response.user != null) {
        // Sign-up is successful, show a message and navigate to the sign-in screen.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sign-up successful! Please verify your email.")),
        );
        Navigator.pushNamed(context, '/sign-in');
      }
    } catch (e) {
      // Handle errors during the sign-up process and display the error message.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error during sign-up: $e")),
      );
    }
  }
}
