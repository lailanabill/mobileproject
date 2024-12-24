import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                children: [
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
                  )
                ],
              ),
            ),

            // Form Section
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                children: [
                  // Full Name Field
                  FadeInUp(
                    duration: Duration(milliseconds: 1800),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  // Email Field
                  FadeInUp(
                    duration: Duration(milliseconds: 1900),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  // Phone Field
                  FadeInUp(
                    duration: Duration(milliseconds: 2000),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  SizedBox(height: 15),
                  // Company Field
                  FadeInUp(
                    duration: Duration(milliseconds: 2100),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Company",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  // Position Field
                  FadeInUp(
                    duration: Duration(milliseconds: 2200),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Position",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  // Password Field
                  FadeInUp(
                    duration: Duration(milliseconds: 2300),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Checkbox for Terms
                  FadeInUp(
                    duration: Duration(milliseconds: 2400),
                    child: Row(
                      children: [
                        Checkbox(value: true, onChanged: (value) {}),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: "I agree to the processing of ",
                              children: [
                                TextSpan(
                                  text: "Personal data",
                                  style: TextStyle(
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Sign Up Button
                  FadeInUp(
                    duration: Duration(milliseconds: 2500),
                    child: GestureDetector(
                      onTap: () {
                        // Implement sign-up functionality here
                        // Example: Navigate to the home screen after successful sign-up
                        Navigator.pushNamed(context, '/HomeScreen');
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
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  // Sign Up with Social Media
                  FadeInUp(
                    duration: Duration(milliseconds: 2600),
                    child: Column(
                      children: [
                        Text(
                          "Sign up with",
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
                  // Navigation to Sign In
                  FadeInUp(
                    duration: Duration(milliseconds: 2700),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/sign-in');
                      },
                      child: Text.rich(
                        TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign in",
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
    );
  }
}
