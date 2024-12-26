import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:reqbot/controllers/signup_controller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

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
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Name Field
                    FadeInUp(
                      duration: const Duration(milliseconds: 1800),
                      child: _buildTextField(
                        controller: controller.nameController,
                        labelText: "Full Name",
                        validator: controller.validateName,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Email Field
                    FadeInUp(
                      duration: const Duration(milliseconds: 1900),
                      child: _buildTextField(
                        controller: controller.emailController,
                        labelText: "Email",
                        validator: controller.validateEmail,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Phone Field
                    FadeInUp(
                      duration: const Duration(milliseconds: 2000),
                      child: _buildTextField(
                        controller: controller.phoneController,
                        labelText: "Phone Number",
                        validator: controller.validatePhone,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Company Field
                    FadeInUp(
                      duration: const Duration(milliseconds: 2100),
                      child: _buildTextField(
                        controller: controller.companyController,
                        labelText: "Company",
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Position Field
                    FadeInUp(
                      duration: const Duration(milliseconds: 2200),
                      child: _buildTextField(
                        controller: controller.positionController,
                        labelText: "Position",
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Password Field
                    FadeInUp(
                      duration: const Duration(milliseconds: 2300),
                      child: _buildTextField(
                        controller: controller.passwordController,
                        labelText: "Password",
                        obscureText: true,
                        validator: controller.validatePassword,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Terms and Conditions
                    FadeInUp(
                      duration: const Duration(milliseconds: 2400),
                      child: ValueListenableBuilder<bool>(
                        valueListenable: controller.isTermsAccepted,
                        builder: (context, value, child) {
                          return Row(
                            children: [
                              Checkbox(
                                value: value,
                                onChanged: (newValue) {
                                  controller.isTermsAccepted.value = newValue ?? false;
                                },
                              ),
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    text: "I agree to the processing of ",
                                    children: [
                                      TextSpan(
                                        text: "Personal data",
                                        style: TextStyle(
                                          color: const Color.fromRGBO(143, 148, 251, 1),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Sign Up Button
                    FadeInUp(
                      duration: const Duration(milliseconds: 2500),
                      child: _buildSignUpButton(),
                    ),
                    const SizedBox(height: 30),

                    // Social Media Sign Up
                    FadeInUp(
                      duration: const Duration(milliseconds: 2600),
                      child: _buildSocialSignUpOptions(),
                    ),
                    const SizedBox(height: 20),

                    // Navigation to Sign In
                    FadeInUp(
                      duration: const Duration(milliseconds: 2700),
                      child: _buildSignInOption(),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 30,
            width: 80,
            height: 200,
            child: FadeInUp(
              duration: const Duration(seconds: 1),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/light-1.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 140,
            width: 80,
            height: 150,
            child: FadeInUp(
              duration: const Duration(milliseconds: 1200),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/light-2.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 40,
            top: 40,
            width: 80,
            height: 150,
            child: FadeInUp(
              duration: const Duration(milliseconds: 1300),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/clock.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: FadeInUp(
              duration: const Duration(milliseconds: 1600),
              child: Container(
                margin: const EdgeInsets.only(top: 50),
                child: const Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  Widget _buildSignUpButton() {
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState?.validate() ?? false) {
          controller.signUp(context);
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
            "Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialSignUpOptions() {
    return Column(
      children: [
        const Text(
          "Sign up with",
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.facebook,
                color: const Color(0xFF5D7CFB),
              ),
            ),
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.g_translate,
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.apple,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSignInOption() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/sign-in');
      },
      child: Text.rich(
        TextSpan(
          text: "Already have an account? ",
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          children: [
            TextSpan(
              text: "Sign in",
              style: TextStyle(
                color: const Color.fromRGBO(143, 148, 251, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
