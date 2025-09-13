import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:porfolio/models/about_model.dart';
import 'package:porfolio/widgets/responsive_builder.dart';
import 'package:porfolio/widgets/section_description.dart';
import 'package:porfolio/widgets/section_header.dart';
import 'package:porfolio/widgets/section_title_gradient.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _aboutMeData = _loadAboutMeData();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ), // Increased duration for effect
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
    // Zoom out from a larger size to normal
    _scaleAnimation = Tween<double>(begin: 1.1, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    // Balloon shaking effect
    _rotationAnimation =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: -0.02), weight: 1),
          TweenSequenceItem(tween: Tween(begin: -0.02, end: 0.02), weight: 1),
          TweenSequenceItem(tween: Tween(begin: 0.02, end: 0.0), weight: 1),
        ]).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  Future<AboutMe> _loadAboutMeData() async {
    final String jsonString = await rootBundle.loadString('data/about_me.json');
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
          return VisibilityDetector(
            key: const Key('about-section-key'),
            onVisibilityChanged: (visibilityInfo) {
              if (visibilityInfo.visibleFraction > 0.3 &&
                  _animationController.status != AnimationStatus.completed) {
                _animationController.forward();
              }
            },
            child: Container(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
        flex: isSmall ? 0 : 2, // Adjusted flex for better spacing
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: RotationTransition(
            turns: _rotationAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: ClipPath(
                  clipper: _BlobClipper(),
                  child: Container(
                    width: isSmall ? 220 : 500,
                    height: isSmall ? 220 : 350,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(data.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      SizedBox(width: isSmall ? 0 : 40, height: isSmall ? 20 : 0),
      Expanded(
        flex: isSmall ? 0 : 2, // Adjusted flex for better spacing
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF1A1A22)
                    : Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
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
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSurface,
                        height: 1.5,
                      ),
                      children: [
                        TextSpan(text: data.bio.intro),
                        TextSpan(
                          text: data.bio.highlight1,
                          style: TextStyle(
                            fontSize: 18,
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
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.7),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    data.paragraph2,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.7),
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

/// A custom clipper to create an irregular "blob" shape.
class _BlobClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(w * 0.5, 0);
    path.cubicTo(w, 0, w, h * 0.7, w * 0.8, h);
    path.cubicTo(w * 0.6, h, 0, h, 0, h * 0.5);
    path.cubicTo(0, 0, w * 0.2, 0, w * 0.5, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // Return true if the shape needs to be re-drawn when the clipper parameters change.
    // For a static shape, false is sufficient.
    return false;
  }
}
