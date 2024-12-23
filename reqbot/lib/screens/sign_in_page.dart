import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Allows resizing when the keyboard appears
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              // Animated Header Section
              Container(
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
                      width: 80,
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
                      width: 80,
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
                      width: 80,
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
              ),

              // Form Section
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    // Email and Password Fields
                    FadeInUp(
                      duration: Duration(milliseconds: 1800),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color.fromRGBO(143, 148, 251, 1),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                  ),
                                ),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email or Phone number",
                                  hintStyle: TextStyle(color: Colors.grey[700]),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey[700]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    
                    // Forgot Password
                    FadeInUp(
                      duration: Duration(milliseconds: 2000),
                      child: GestureDetector(
                        onTap: () {
                          // Handle "Forgot Password" functionality
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
                      ),
                    ),
                    SizedBox(height: 20),

                    // Login Button
                    FadeInUp(
                      duration: Duration(milliseconds: 1900),
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
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Social Media Login Options
                    FadeInUp(
                      duration: Duration(milliseconds: 2100),
                      child: Column(
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
                      ),
                    ),
                    SizedBox(height: 20),

                    // Navigation to Sign Up
                    FadeInUp(
                      duration: Duration(milliseconds: 2200),
                      child: GestureDetector(
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
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
