import 'package:flutter/material.dart';

class SectionDescription extends StatelessWidget {
  final String text;

  const SectionDescription({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge,
      textAlign: TextAlign.center,
    );
  }
}
