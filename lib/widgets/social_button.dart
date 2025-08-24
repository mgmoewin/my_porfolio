import 'package:flutter/material.dart';
import 'package:porfolio/widgets/glass.card.dart';

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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GlassCard(
        child: TextButton(
          onPressed: onPressed,
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
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
