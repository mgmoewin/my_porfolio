import 'package:flutter/material.dart';

class SectionTitleGradient extends StatelessWidget {
  final String title;

  const SectionTitleGradient({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[Colors.blue.shade700, Colors.purple.shade700],
        ).createShader(bounds);
      },
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
