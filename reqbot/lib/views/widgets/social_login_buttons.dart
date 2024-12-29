import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialIcon(Icons.facebook, Colors.blue),
        const SizedBox(width: 10),
        _socialIcon(Icons.g_translate, Colors.red),
        const SizedBox(width: 10),
        _socialIcon(Icons.apple, Colors.black),
      ],
    );
  }

  Widget _socialIcon(IconData icon, Color color) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: Icon(icon, color: color),
    );
  }
}
