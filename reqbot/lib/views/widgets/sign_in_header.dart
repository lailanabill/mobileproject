import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class SignInHeader extends StatelessWidget {
  final double logoSize;

  const SignInHeader({Key? key, required this.logoSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 30,
            width: logoSize,
            height: 200,
            child: FadeInUp(
              child: Image.asset('assets/images/light-1.png'),
            ),
          ),
          Positioned(
            left: 140,
            width: logoSize,
            height: 150,
            child: FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: Image.asset('assets/images/light-2.png'),
            ),
          ),
          Positioned(
            right: 40,
            top: 40,
            width: logoSize,
            height: 150,
            child: FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: Image.asset('assets/images/clock.png'),
            ),
          ),
          Center(
            child: FadeInUp(
              delay: const Duration(milliseconds: 600),
              child: const Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
