import 'package:flutter/material.dart';

class SectionDescription extends StatelessWidget {
  final String text;

  const SectionDescription({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, color: Colors.black87),
      textAlign: TextAlign.center,
    );
  }
}
