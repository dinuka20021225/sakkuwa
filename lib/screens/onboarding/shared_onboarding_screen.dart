import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SharedOnboardingScreen extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  const SharedOnboardingScreen({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Animate(
          effects: const [FadeEffect(), ScaleEffect()],
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            width: 300,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Animate(
          effects: const [FadeEffect(), ScaleEffect()],
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: "title",
              height: 1.2,
              fontSize: 35,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Animate(
          effects: const [FadeEffect(), ScaleEffect()],
          child: Text(
            description,
            style: const TextStyle(
              //fontFamily: "title",
              fontSize: 16,
              height: 1.6,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
