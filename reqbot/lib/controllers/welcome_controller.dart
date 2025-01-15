import 'package:flutter/material.dart';

// WelcomeController handles navigation logic for the Welcome Screen,
// directing users to either the Sign-Up or Sign-In screens.
class WelcomeController {
  // Navigates the user to the Sign-Up screen.
  //
  // Parameters:
  // - context: The BuildContext used for navigation.
  //
  // This method pushes the Sign-Up screen onto the navigation stack
  // using the route name '/sign-up'.
  void navigateToSignUp(BuildContext context) {
    Navigator.pushNamed(context, '/sign-up');
  }

  // Navigates the user to the Sign-In screen.
  //
  // Parameters:
  // - context: The BuildContext used for navigation.
  //
  // This method pushes the Sign-In screen onto the navigation stack
  // using the route name '/sign-in'.
  void navigateToSignIn(BuildContext context) {
    Navigator.pushNamed(context, '/sign-in');
  }
}
