import 'package:flutter/material.dart';
import 'package:porfolio/widgets/glass.card.dart';
import 'package:porfolio/widgets/responsive_builder.dart';

class SocialButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback? onPressed;

  const SocialButton({
    super.key,
    required this.icon,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ResponsiveBuilder(
      builder: (context, screenSize) {
        final bool isSmall = screenSize == ScreenSizeCategory.mobile;
        final bool isVerySmall = screenSize == ScreenSizeCategory.smallMobile;
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isVerySmall ? 2 : (isSmall ? 4 : 10),
          ),
          child: GlassCard(
            child: TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: isVerySmall ? 8 : (isSmall ? 12 : 16),
                  vertical: isSmall || isVerySmall ? 10 : 12,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconTheme(
                    data: IconThemeData(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                      size: 18,
                    ),
                    child: icon,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    text,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontSize: isSmall || isVerySmall ? 14 : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
