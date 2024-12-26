import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:reqbot/controllers/signin_controller.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final SignInController controller = SignInController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // For small screens, increase padding and margins
          double padding = constraints.maxWidth < 600 ? 15.0 : 30.0;
          double textSize = constraints.maxWidth < 600 ? 18.0 : 20.0;
          double logoSize = constraints.maxWidth < 600 ? 60.0 : 100.0;

          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildHeader(logoSize),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        _buildTextField(
                          controller: controller.emailController,
                          hintText: "Email or Phone number",
                          validator: controller.validateEmail,
                        ),
                        SizedBox(height: 15),
                        _buildTextField(
                          controller: controller.passwordController,
                          hintText: "Password",
                          obscureText: true,
                          validator: controller.validatePassword,
                        ),
                        SizedBox(height: 15),
                        _buildForgotPassword(),
                        SizedBox(height: 20),
                        _buildLoginButton(context, textSize),
                        SizedBox(height: 30),
                        _buildSocialLoginOptions(),
                        SizedBox(height: 20),
                        _buildSignUpOption(context),
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

  Widget _buildHeader(double logoSize) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 30,
            width: logoSize,
            height: 200,
            child: FadeInUp(
              duration: Duration(seconds: 1),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/light-1.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 140,
            width: logoSize,
            height: 150,
            child: FadeInUp(
              duration: Duration(milliseconds: 1200),
              child: Container(
                decoration: BoxDecoration(
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
            width: logoSize,
            height: 150,
            child: FadeInUp(
              duration: Duration(milliseconds: 1300),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/clock.png'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            child: FadeInUp(
              duration: Duration(milliseconds: 1600),
              child: Container(
                margin: EdgeInsets.only(top: 50),
                child: Center(
                  child: Text(
                    "Login",
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
    required String hintText,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
        hintStyle: TextStyle(color: Colors.grey[700]),
      ),
      validator: validator,
    );
  }

  Widget _buildForgotPassword() {
    return GestureDetector(
      onTap: () {
        // Implement Forgot Password logic
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          "Forgot Password?",
          style: TextStyle(
            color: Color.fromRGBO(143, 148, 251, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, double textSize) {
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState?.validate() ?? false) {
          controller.login(context);
        }
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(143, 148, 251, 1),
              Color.fromRGBO(143, 148, 251, .6),
            ],
          ),
        ),
        child: Center(
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: textSize, // Responsive text size
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginOptions() {
    return Column(
      children: [
        Text(
          "Sign in with",
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.facebook,
                color: Color(0xFF5D7CFB),
              ),
            ),
            SizedBox(width: 10),
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.g_translate,
                color: Colors.red,
              ),
            ),
            SizedBox(width: 10),
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

  Widget _buildSignUpOption(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/sign-up');
      },
      child: Text.rich(
        TextSpan(
          text: "Don't have an account? ",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          children: [
            TextSpan(
              text: "Sign up",
              style: TextStyle(
                color: Color.fromRGBO(143, 148, 251, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
