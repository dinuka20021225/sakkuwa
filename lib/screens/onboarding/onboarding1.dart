import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Animate(
            effects: [FadeEffect(), ScaleEffect()],
            child: Image.asset(
              "assets/images/logo.png",
              width: 450,
            ),
          ),
          // Animate(
          //   effects: [FadeEffect(), ScaleEffect()],
          //   child: const Text(
          //     "wdhqfndaj​ka",
          //     style: TextStyle(
          //       fontFamily: "title",
          //       fontSize: 50,
          //       //fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
