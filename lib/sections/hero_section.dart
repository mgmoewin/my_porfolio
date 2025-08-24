import 'package:flutter/material.dart';
import 'package:porfolio/main.dart';
import 'package:porfolio/widgets/social_button.dart';
import 'package:porfolio/widgets/available_for_project.dart';
import 'package:porfolio/widgets/typing_text.dart';
import 'package:porfolio/sections/particle_field.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  _HeroSectionState createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check the current theme mode to apply the correct background.
    final isDark = themeModeNotifier.value == ThemeMode.dark;

    return Container(
      height: MediaQuery.of(context).size.height - 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: isDark
            ? LinearGradient(
                colors: [
                  Colors.purple.shade900,
                  Colors.black,
                  Colors.blue.shade900,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : const LinearGradient(
                colors: [
                  Color(0xFFE0E0FF),
                  Color(0xFFF9F9F9),
                  Color(0xFFE0E0FF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
      ),
      child: Stack(
        children: [
          const Positioned.fill(child: ParticleField()),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Moe Win',
                  style: TextStyle(fontSize: 62, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // The button in the image is "Full Stack Developer"
                const TypingText(
                  texts: [
                    'Junior Flutter Developer',
                    '    Flutter Enthusiast',
                    '  Mobile App Developer',
                    '    UI/UX Designer',
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 600,
                  child: Text(
                    'Crafting exceptional digital experiences with clean code and thoughtful design',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SocialButton(
                      icon: Icon(Icons.code),
                      text: 'GitHub',
                      onPressed: null,
                    ),
                    SocialButton(
                      icon: Icon(Icons.group),
                      text: 'LinkedIn',
                      onPressed: null,
                    ),
                    SocialButton(
                      icon: Icon(Icons.email),
                      text: 'Email',
                      onPressed: null,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const AvailableForProjectsWidget(),
                const SizedBox(height: 20),
                Text(
                  'Scroll for more',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
