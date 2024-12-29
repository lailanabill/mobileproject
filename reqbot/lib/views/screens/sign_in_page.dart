import 'package:flutter/material.dart';
import 'package:reqbot/controllers/signin_controller.dart';
import '../widgets/sign_in_header.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/login_button.dart';
import '../widgets/social_login_buttons.dart';
import '../widgets/sign_up_option.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final SignInController controller = SignInController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double padding = constraints.maxWidth < 600 ? 15.0 : 30.0;
          final double logoSize = constraints.maxWidth < 600 ? 60.0 : 100.0;

          return SingleChildScrollView(
            child: Column(
              children: [
                SignInHeader(logoSize: logoSize),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: controller.emailController,
                          hintText: "Email or Phone number",
                          validator: controller.validateEmail,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          controller: controller.passwordController,
                          hintText: "Password",
                          obscureText: true,
                          validator: controller.validatePassword,
                        ),
                        const SizedBox(height: 20),
                        LoginButton(
                          formKey: _formKey,
                          controller: controller,
                        ),
                        const SizedBox(height: 30),
                        const SocialLoginButtons(),
                        const SizedBox(height: 20),
                        const SignUpOption(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
