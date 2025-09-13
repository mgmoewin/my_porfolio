import 'package:flutter/material.dart';
import 'package:porfolio/widgets/responsive_builder.dart';

class SectionTitleGradient extends StatelessWidget {
  final String title;

  const SectionTitleGradient({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, screenSize) {
        double fontSize;
        if (screenSize == ScreenSizeCategory.smallMobile ||
            screenSize == ScreenSizeCategory.mobile) {
          fontSize = 30;
        } else {
          fontSize = 50;
        }

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
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
