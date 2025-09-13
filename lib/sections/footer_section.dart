import 'package:flutter/material.dart';
import 'package:porfolio/widgets/glass.card.dart';
import 'package:porfolio/widgets/responsive_builder.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ResponsiveBuilder(
      builder: (context, screenSize) {
        final isSmallScreen =
            screenSize == ScreenSizeCategory.smallMobile ||
            screenSize == ScreenSizeCategory.mobile;
        final horizontalPadding = isSmallScreen ? 20.0 : 50.0;
        final verticalPadding = isSmallScreen ? 15.0 : 20.0;
        final textPadding = isSmallScreen ? 12.0 : 8.0;
        final textAlign = isSmallScreen ? TextAlign.center : TextAlign.center;

        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          child: GlassCard(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: textPadding),
              child: Text(
                '© ${DateTime.now().year} Moe Win. All rights reserved. Built with Flutter & Dart.',
                textAlign: textAlign,
                softWrap: true,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
