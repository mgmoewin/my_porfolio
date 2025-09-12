import 'package:flutter/material.dart';
import 'package:porfolio/widgets/glass.card.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: GlassCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            '© ${DateTime.now().year} Moe Win. All rights reserved. Built with Flutter ❤️ & Dart.',

            textAlign: TextAlign.center,
            softWrap: true,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
