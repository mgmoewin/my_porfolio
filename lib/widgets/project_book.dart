import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:porfolio/widgets/tag_chip.dart';
import 'package:porfolio/widgets/gradient_button.dart';

import 'responsive_builder.dart';

class ProjectBook extends StatefulWidget {
  final List<Map<String, dynamic>> projects;

  const ProjectBook({super.key, required this.projects});

  @override
  State<ProjectBook> createState() => _ProjectBookState();
}

class _ProjectBookState extends State<ProjectBook>
    with TickerProviderStateMixin {
  late AnimationController _pageTurnController;
  late AnimationController _pageTurnBackController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageTurnController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _pageTurnBackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _pageTurnController.dispose();
    _pageTurnBackController.dispose();
    super.dispose();
  }

  void _turnPage() {
    if (_currentPage < widget.projects.length - 1) {
      _pageTurnController.forward(from: 0.0).then((_) {
        setState(() {
          _currentPage++;
        });
        _pageTurnController.reset();
      });
    }
  }

  void _turnPageBack() {
    if (_currentPage > 0) {
      _pageTurnBackController.forward(from: 0.0).then((_) {
        setState(() {
          _currentPage--;
        });
        _pageTurnBackController.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final currentProject = widget.projects[_currentPage];

    return ResponsiveBuilder(
      builder: (context, screenSize) {
        double bookWidth;
        double bookHeight;

        if (screenSize == ScreenSizeCategory.smallMobile ||
            screenSize == ScreenSizeCategory.mobile) {
          bookWidth = MediaQuery.of(context).size.width * 0.9;
          bookHeight = bookWidth * 1.25; // Maintain aspect ratio
        } else if (screenSize == ScreenSizeCategory.tablet) {
          bookWidth = 800;
          bookHeight = 500;
        } else {
          bookWidth = 900;
          bookHeight = 520.5;
        }

        double pageWidth = bookWidth / 2;

        return Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.identity()..setEntry(3, 2, 0.001), // Perspective
          child: SizedBox(
            width: bookWidth,
            height: bookHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // The static open book background (Left Page)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: pageWidth,
                    height: bookHeight,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF0D1117) : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                      border: Border(
                        right: BorderSide(
                          color: Colors.grey.shade700,
                          width: 2,
                        ),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: _currentPage > 0 ? _turnPageBack : null,
                      child: _ProjectDetailsPage(
                        project: currentProject,
                        currentIndex: _currentPage,
                        totalProjects: widget.projects.length,
                      ),
                    ),
                  ),
                ),
                // The static open book background (Right Page)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: pageWidth,
                    height: bookHeight,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1A1A22) : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: _turnPage,
                      child: _ProjectVisualsPage(project: currentProject),
                    ),
                  ),
                ),
                // The animated turning page (for turning forward)
                AnimatedBuilder(
                  animation: _pageTurnController,
                  builder: (context, child) {
                    if (_pageTurnController.value == 0) {
                      return const SizedBox.shrink();
                    }
                    final angle = (_pageTurnController.value) * -math.pi;
                    return Align(
                      alignment: Alignment.centerRight,
                      child: Transform(
                        alignment: Alignment.centerLeft, // Pivot from the spine
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001) // Perspective
                          ..rotateY(-angle),
                        child: SizedBox(
                          width: pageWidth,
                          height: bookHeight,
                          child: _pageTurnController.value < 0.5
                              // Front of the turning page (current project's right side)
                              ? _ProjectVisualsPage(project: currentProject)
                              // Back of the turning page (next project's left side, but flipped)
                              : Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()
                                    ..rotateY(math.pi),
                                  child: _ProjectDetailsPage(
                                    project: widget.projects[_currentPage + 1],
                                    currentIndex: _currentPage + 1,
                                    totalProjects: widget.projects.length,
                                  ),
                                ),
                        ),
                      ),
                    );
                  },
                ),
                // The animated turning page (for turning backward)
                AnimatedBuilder(
                  animation: _pageTurnBackController,
                  builder: (context, child) {
                    if (_pageTurnBackController.value == 0) {
                      return const SizedBox.shrink();
                    }
                    final angle = (_pageTurnBackController.value) * math.pi;
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Transform(
                        alignment:
                            Alignment.centerRight, // Pivot from the spine
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001) // Perspective
                          ..rotateY(-angle),
                        child: SizedBox(
                          width: pageWidth,
                          height: bookHeight,
                          child: _pageTurnBackController.value < 0.5
                              // Front of the turning page (current project's left side)
                              ? _ProjectDetailsPage(
                                  project: currentProject,
                                  currentIndex: _currentPage,
                                  totalProjects: widget.projects.length,
                                )
                              // Back of the turning page (previous project's right side, but flipped)
                              : Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()
                                    ..rotateY(math.pi),
                                  child: _ProjectVisualsPage(
                                    project: widget.projects[_currentPage - 1],
                                  ),
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProjectDetailsPage extends StatelessWidget {
  final Map<String, dynamic> project;
  final int currentIndex;
  final int totalProjects;

  const _ProjectDetailsPage({
    required this.project,
    required this.currentIndex,
    required this.totalProjects,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ResponsiveBuilder(
      builder: (context, screenSize) {
        final bool isSmall =
            screenSize == ScreenSizeCategory.mobile ||
            screenSize == ScreenSizeCategory.smallMobile;
        final bool isTablet = screenSize == ScreenSizeCategory.tablet;

        double titleSize = isSmall
            ? 18
            : (isTablet ? 20 : theme.textTheme.headlineSmall!.fontSize!);
        double bodySize = isSmall
            ? 12
            : (isTablet ? 14 : theme.textTheme.bodyLarge!.fontSize!);
        double buttonPadding = isSmall ? 8 : 12;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Project ${currentIndex + 1}',
                  style: TextStyle(
                    fontSize: 20,
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 48),
                Text(
                  project['title'],
                  style: TextStyle(
                    fontSize: titleSize,
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 26),
                Text(
                  'Key Features',
                  style: TextStyle(
                    fontSize: 20,
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 8),
                ...((project['features'] as List<dynamic>?) ?? []).map<Widget>((
                  feature,
                ) {
                  return FeatureListItem(
                    icon: Icons.check_circle_outline,
                    text: feature as String,
                    bodySize: bodySize,
                  );
                }).toList(),
                // Text(
                //   project['description'] as String,
                //   style: TextStyle(fontSize: bodySize, color: theme.colorScheme.onSurface.withOpacity(0.7), height: 1.5,),
                // ),
                const SizedBox(height: 150),
                Wrap(
                  spacing: buttonPadding,
                  runSpacing: 12,
                  children: [
                    GradientButton(
                      icon: Icons.arrow_upward_rounded,

                      text: 'Live Demo',
                      onPressed: () {
                        // TODO: Add Live Demo URL logic
                      },
                    ),
                    _GlassRepoButton(
                      onPressed: () {
                        // TODO: Add Source Code URL logic
                      },
                      icon: Icon(
                        Icons.code,

                        color: theme.colorScheme.onSurface,
                      ),
                      label: Text(
                        'View Repository',
                        style: TextStyle(
                          fontSize: 13,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GlassRepoButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;
  final Widget label;

  const _GlassRepoButton({
    this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardColor = isDark
        ? Colors.white.withOpacity(0.1)
        : Colors.black.withOpacity(0.05);

    final borderColor = isDark
        ? Colors.white.withOpacity(0.2)
        : Colors.black.withOpacity(0.1);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            color: cardColor,
            border: Border.all(color: borderColor, width: 1.0),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [icon, const SizedBox(width: 8), label],
          ),
        ),
      ),
    );
  }
}

class FeatureListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final double bodySize;

  const FeatureListItem({
    super.key,
    required this.icon,
    required this.text,
    required this.bodySize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
      ), // Spacing between items
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
        children: [
          Icon(
            icon,
            color: Colors.green.shade400, // Color for the checkmark
            size: bodySize,
          ),
          const SizedBox(width: 12), // Spacing between icon and text
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;

  const _GlassButton({required this.text, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardColor = isDark
        ? Colors.white.withOpacity(0.1)
        : Colors.black.withOpacity(0.05);

    final borderColor = isDark
        ? Colors.white.withOpacity(0.2)
        : Colors.black.withOpacity(0.1);

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: cardColor,
          border: Border.all(color: borderColor, width: 1.0),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: theme.colorScheme.onSurface.withOpacity(0.8),
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(text, style: TextStyle(color: theme.colorScheme.onSurface)),
          ],
        ),
      ),
    );
  }
}

class _ProjectVisualsPage extends StatefulWidget {
  final Map<String, dynamic> project;
  const _ProjectVisualsPage({required this.project});

  @override
  State<_ProjectVisualsPage> createState() => _ProjectVisualsPageState();
}

class _ProjectVisualsPageState extends State<_ProjectVisualsPage> {
  Future<Map<String, String>>? _techIconsFuture;

  @override
  void initState() {
    super.initState();
    _techIconsFuture = _loadTechIcons();
  }

  Future<Map<String, String>> _loadTechIcons() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'data/tech_icons.json',
      );
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return jsonMap.map((key, value) => MapEntry(key, value as String));
    } catch (e) {
      // If the file fails to load, return an empty map.
      // The UI will fall back to showing text chips.
      debugPrint("Failed to load tech icons: $e");
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, screenSize) {
        final bool isSmall =
            screenSize == ScreenSizeCategory.mobile ||
            screenSize == ScreenSizeCategory.smallMobile;
        final bool isTablet = screenSize == ScreenSize.tablet;
        final theme = Theme.of(context);

        double titleSize = isSmall
            ? 16
            : (isTablet ? 18 : (theme.textTheme.titleLarge!.fontSize ?? 22));
        double imageHeight = isSmall ? 150 : (isTablet ? 200 : 250);

        Widget technologiesWidget = FutureBuilder<Map<String, String>>(
          future: _techIconsFuture,
          builder: (context, snapshot) {
            final techIcons = snapshot.data ?? {};
            final technologies =
                (widget.project['technologies'] as List<dynamic>?) ?? [];

            return Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: technologies.map<Widget>((tech) {
                final techName = tech as String;
                if (techIcons.containsKey(techName)) {
                  return _TechIcon(
                    imagePath: techIcons[techName]!,
                    tooltip: techName,
                  );
                } else {
                  return TagChip(text: techName); // Fallback to chip
                }
              }).toList(),
            );
          },
        );

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    widget.project['imagePath'],
                    height: 200 + imageHeight,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Technologies Used',
                  style: TextStyle(
                    fontSize: titleSize,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 12),
                technologiesWidget,
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TechIcon extends StatelessWidget {
  final String imagePath;
  final String tooltip;

  const _TechIcon({required this.imagePath, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey.shade800
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(imagePath, fit: BoxFit.contain),
      ),
    );
  }
}
