import 'package:flutter/material.dart';
import 'package:porfolio/main.dart';
import 'package:porfolio/sections/hero_section.dart';
import 'package:porfolio/widgets/glass.card.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Header(),
      ),
      body: SingleChildScrollView(
        child: Column(children: [const SizedBox(height: 150.0), HeroSection()]),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = themeModeNotifier.value == ThemeMode.dark;
    final theme = Theme.of(context);

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // This is the glass card with the nav items
          GlassCard(
            child: Row(
              children: [
                Text(
                  'MW',
                  style: theme.textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    foreground: Paint()
                      ..shader =
                          const LinearGradient(
                            colors: <Color>[
                              Colors.purpleAccent,
                              Colors.blueAccent,
                            ],
                          ).createShader(
                            const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                          ),
                  ),
                ),
                const SizedBox(width: 30),
                ..._buildNavItems(context),

                IconButton(
                  icon: Icon(
                    isDark ? Icons.light_mode : Icons.dark_mode,
                    color: theme.colorScheme.onSurface,
                  ),
                  onPressed: () {
                    themeModeNotifier.value = isDark
                        ? ThemeMode.light
                        : ThemeMode.dark;
                  },
                ),
              ],
            ),
          ),

          // Theme toggle button
        ],
      ),
    );
  }

  List<Widget> _buildNavItems(BuildContext context) {
    final navItems = ['Overview', 'Stack', 'Experience', 'Projects', 'Contact'];
    final theme = Theme.of(context);
    return navItems.map((item) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextButton(
          onPressed: () {},
          child: Text(
            item,
            style: theme.textTheme.bodyMedium!.copyWith(
              // color: theme.colorScheme.onBackground.withOpacity(0.7),
            ),
          ),
        ),
      );
    }).toList();
  }
}
