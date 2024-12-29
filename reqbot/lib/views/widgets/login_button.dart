import 'package:flutter/material.dart';
import 'package:reqbot/controllers/signin_controller.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final SignInController controller;

  const LoginButton({
    Key? key,
    required this.formKey,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (formKey.currentState?.validate() ?? false) {
          controller.login(context);
        }
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(143, 148, 251, 1),
              Color.fromRGBO(143, 148, 251, .6),
            ],
          ),
        ),
        child: const Center(
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18, // Responsive text size if needed
            ),
          ),
        ),
      ),
    );
  }
}
