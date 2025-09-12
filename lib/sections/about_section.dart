import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:porfolio/models/about_model.dart';
import 'package:porfolio/widgets/responsive_builder.dart';
import 'package:porfolio/widgets/section_description.dart';
import 'package:porfolio/widgets/section_header.dart';
import 'package:porfolio/widgets/section_title_gradient.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  Future<AboutMe>? _aboutMeData;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _aboutMeData = _loadAboutMeData();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
  }

  Future<AboutMe> _loadAboutMeData() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/about_me.json',
    );
    final jsonResponse = json.decode(jsonString);
    try {
      return AboutMe.fromJson(jsonResponse);
    } catch (e) {
      // ignore: avoid_print
      print('Error parsing AboutMe data: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AboutMe>(
      future: _aboutMeData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final aboutMeData = snapshot.data!;
          _animationController.forward(); // Start animation when data is ready
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SectionHeader(
                        text: 'Get To Know Me',
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 30),
                      SectionTitleGradient(title: aboutMeData.title),
                      const SizedBox(height: 10),
                      Container(
                        width: 60,
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          gradient: LinearGradient(
                            colors: [
                              Colors.purple.shade500,
                              Colors.blue.shade500,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SectionDescription(text: aboutMeData.description),
                      const SizedBox(height: 50),
                      ResponsiveBuilder(
                        builder: (context, screenSize) {
                          bool isSmall =
                              screenSize == ScreenSizeCategory.smallMobile ||
                              screenSize == ScreenSizeCategory.mobile;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: isSmall
                                ? Column(
                                    children: _buildColumns(
                                      aboutMeData,
                                      isSmall,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: _buildColumns(
                                      aboutMeData,
                                      isSmall,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No data found.'));
        }
      },
    );
  }

  List<Widget> _buildColumns(AboutMe data, bool isSmall) {
    return [
      Expanded(
        flex: isSmall ? 0 : 1,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10,
              ),
            ],
          ),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: CircleAvatar(
                radius: isSmall ? 100 : 150,
                backgroundImage: AssetImage(data.imageUrl),
              ),
            ),
          ),
        ),
      ),
      SizedBox(width: isSmall ? 0 : 20, height: isSmall ? 20 : 0),
      Expanded(
        flex: isSmall ? 0 : 1,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '👋 Hello, I\'m Moe Win',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFC8F6FF),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFBEABFD),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFFC8EB),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(text: data.bio.intro),
                        TextSpan(
                          text: data.bio.highlight1,
                          style: TextStyle(
                            color: Colors.blue.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(text: data.bio.connector),
                        TextSpan(
                          text: data.bio.highlight2,
                          style: TextStyle(
                            color: Colors.purple.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(text: data.bio.outro),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    data.paragraph1,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    data.paragraph2,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ];
  }
}
