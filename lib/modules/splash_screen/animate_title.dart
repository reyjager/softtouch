import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class AnimatedTitle extends StatelessWidget {
  final String title;
  const AnimatedTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedTextKit(
        repeatForever: false,
        totalRepeatCount: 1,
        animatedTexts: [
          TypewriterAnimatedText(
            title,
            textStyle: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            speed: const Duration(milliseconds: 100), // typing speed
          ),
        ],
      ),
    );
  }
}
