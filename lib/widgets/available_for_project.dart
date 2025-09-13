import 'package:flutter/material.dart';
import 'dart:ui'; // Import this for ImageFilter

class AvailableForProjectsWidget extends StatefulWidget {
  final VoidCallback? onTap;
  const AvailableForProjectsWidget({super.key, this.onTap});

  @override
  State<AvailableForProjectsWidget> createState() =>
      _AvailableForProjectsWidgetState();
}

class _AvailableForProjectsWidgetState
    extends State<AvailableForProjectsWidget> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Define the colors for the glass effect
    final glassColor = Colors.greenAccent.withOpacity(
      _isHovering ? (isDark ? 0.2 : 0.15) : (isDark ? 0.1 : 0.05),
    );
    final borderColor = Colors.greenAccent.withOpacity(
      _isHovering ? (isDark ? 0.4 : 0.3) : (isDark ? 0.2 : 0.1),
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: glassColor,
                border: Border.all(color: borderColor, width: 1.0),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisSize:
                    MainAxisSize.min, // To make the container wrap its content
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.withOpacity(0.5),
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Available for projects',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
