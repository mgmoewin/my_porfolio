import 'package:flutter/material.dart';
import 'package:porfolio/main.dart';
import 'package:porfolio/widgets/social_button.dart';
import 'package:porfolio/widgets/available_for_project.dart';
import 'package:porfolio/widgets/typing_text.dart';
import 'package:porfolio/widgets/scroll_for_more.dart';
import 'package:porfolio/widgets/particle_field.dart';
import 'package:porfolio/widgets/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check the current theme mode to apply the correct background.
    final isDark = themeModeNotifier.value == ThemeMode.dark;

    return ResponsiveBuilder(
      builder: (context, screenSize) {
        double titleFontSize = 62;
        double descriptionWidth = 600;
        MainAxisAlignment columnAlignment = MainAxisAlignment.center;
        CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center;
        TextAlign textAlign = TextAlign.center;

        if (screenSize == ScreenSizeCategory.smallMobile) {
          titleFontSize = 32;
          descriptionWidth = MediaQuery.of(context).size.width * 0.9;
        } else if (screenSize == ScreenSizeCategory.mobile) {
          titleFontSize = 42;
          descriptionWidth = MediaQuery.of(context).size.width * 0.8;
        } else if (screenSize == ScreenSizeCategory.tablet) {
          titleFontSize = 52;
          descriptionWidth = 600;
        }

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: columnAlignment,
                    crossAxisAlignment: crossAxisAlignment,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          ' Moe Win ( Mazhai ) ',
                          softWrap: false,
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                        width: descriptionWidth,
                        child: Text(
                          'Crafting exceptional digital experiences with clean code and thoughtful design',
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: textAlign,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        alignment: WrapAlignment.center,

                        children: [
                          SocialButton(
                            icon: const Icon(Icons.code),
                            text: 'GitHub',
                            onPressed: () =>
                                _launchURL('https://github.com/mgmoewin'),
                          ),
                          SocialButton(
                            icon: const Icon(Icons.group),
                            text: 'LinkedIn',
                            onPressed: () => _launchURL(
                              'https://www.linkedin.com/in/moe-win-3910411ab/',
                            ),
                          ),
                          SocialButton(
                            icon: const Icon(Icons.email),
                            text: 'Email',
                            onPressed: () =>
                                _launchURL('mailto:moewin4070@gmail.com'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      const AvailableForProjectsWidget(),
                      const SizedBox(height: 20),
                      const ScrollForMore(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
