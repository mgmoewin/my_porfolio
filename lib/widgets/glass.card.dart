import 'package:flutter/material.dart';
import 'dart:ui';

class GlassCard extends StatelessWidget {
  final Widget child;
  const GlassCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Determine if the current theme is dark
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Adjust the colors based on the theme
    final cardColor = isDark
        ? Colors.white.withOpacity(0.1) // More subtle for dark mode
        : Colors.black.withOpacity(0.05); // Very subtle for light mode

    final borderColor = isDark
        ? Colors.white.withOpacity(0.2) // Lighter border for dark mode
        : Colors.black.withOpacity(0.1); // Darker border for light mode

    return ClipRRect(
      borderRadius: BorderRadius.circular(45),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            border: Border.all(color: borderColor, width: 1.0),
            borderRadius: BorderRadius.circular(45),
          ),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: child,
        ),
      ),
    );
  }
}
