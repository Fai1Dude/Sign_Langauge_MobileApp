import 'package:flutter/material.dart';
import 'signup_screen.dart'; // Adjust path if needed

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          SizedBox.expand(
            child: Image.asset(
              'assets/1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Invisible tappable button over "ابدأ"
          Align(
            alignment: const Alignment(0, 0.42), // Adjust to align with text
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
              child: Container(
                width: 160,
                height: 60,
                color: Colors.transparent, // Invisible but tappable
              ),
            ),
          ),
        ],
      ),
    );
  }
}
