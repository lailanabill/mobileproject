import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:reqbot/controllers/signup_controller.dart';
import '../widgets/auth_header.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/gradient_button.dart';
import '../widgets/social_auth_buttons.dart';
import '../widgets/auth_navigation.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final SignUpController controller = SignUpController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AuthHeader(title: "Sign Up", height: 300),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: controller.nameController,
                      labelText: "Full Name",
                      validator: controller.validateName,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: controller.emailController,
                      labelText: "Email",
                      validator: controller.validateEmail,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: controller.phoneController,
                      labelText: "Phone Number",
                      keyboardType: TextInputType.phone,
                      validator: controller.validatePhone,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: controller.companyController,
                      labelText: "Company",
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: controller.positionController,
                      labelText: "Position",
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: controller.passwordController,
                      labelText: "Password",
                      obscureText: true,
                      validator: controller.validatePassword,
                    ),
                    const SizedBox(height: 20),
                    GradientButton(
                      text: "Sign Up",
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          controller.signUp(context);
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                    const SocialAuthButtons(),
                    const SizedBox(height: 20),
                    AuthNavigation(
                      questionText: "Already have an account?",
                      actionText: "Sign in",
                      onTap: () => Navigator.pushNamed(context, '/sign-in'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
