import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Space Grotesk',
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFBB86FC),
      secondary: Color(0xFF03DAC6),
      surface: Color(0xFF121212),
      onSurface: Colors.white,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 72.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(fontSize: 18.0, color: Colors.white70),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Space Grotesk',
    // Note: The gradient background is handled in the HeroSection, not here.
    scaffoldBackgroundColor: const Color(0xFFF9F9F9),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF6200EE),
      secondary: Color(0xFF03DAC6),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF121212),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 72.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF121212),
      ),
      headlineMedium: TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF121212),
      ),
      bodyLarge: TextStyle(fontSize: 18.0, color: Color(0xFF424242)),
    ),
  );
}
