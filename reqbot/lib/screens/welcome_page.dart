import 'package:flutter/material.dart';
import 'package:animated_introduction/animated_introduction.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedIntroduction(
        slides: [
          // First Slide
          SingleIntroScreen(
            title: "Welcome",
            description: "Discover amazing features.",
            imageAsset: 'assets/images/onboard_one.png',
          ),
          // Second Slide with Buttons
          SingleIntroScreen(
            title: "Get Started",
            description: "Sign up or log in to explore the app.",
            imageAsset: 'assets/images/onboard_two.png',
          ),
        ],
        onSkip: () {
          Navigator.pushNamed(context, '/sign-up');
        },
        onDone: () {
          Navigator.pushNamed(context, '/sign-in');
        },
        indicatorType: IndicatorType.circle,
      ),
    );
  }
}
