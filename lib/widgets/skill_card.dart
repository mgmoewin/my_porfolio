import 'package:flutter/material.dart';

class SkillCard extends StatefulWidget {
  final String label;
  final String imagePath;
  final bool isSelected;

  const SkillCard({
    super.key,
    required this.label,
    required this.imagePath,
    this.isSelected = false,
  });

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Determine colors based on theme and selection state
    Color cardColor;
    if (widget.isSelected || _isHovering) {
      cardColor = isDark ? const Color(0xFF2A2A38) : Colors.white;
    } else {
      cardColor = isDark ? const Color(0xFF1A1A22) : Colors.grey.shade100;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 150,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(150),
          boxShadow: (widget.isSelected || _isHovering) && !isDark
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(widget.imagePath, height: 120, width: 150),
            const SizedBox(height: 25),
            Text(
              widget.label,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
