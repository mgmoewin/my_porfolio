import 'package:flutter/material.dart';
import 'package:porfolio/main.dart';
import 'package:porfolio/sections/hero_section.dart';
import 'package:porfolio/widgets/glass.card.dart';
import 'package:porfolio/widgets/responsive_builder.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, screenSize) {
        final isMobile =
            screenSize == ScreenSizeCategory.mobile ||
            screenSize == ScreenSizeCategory.smallMobile;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: Header(isMobile: isMobile),
          ),
          drawer: isMobile ? const MobileDrawer() : null,
          body: const SingleChildScrollView(
            child: Column(children: [SizedBox(height: 120.0), HeroSection()]),
          ),
        );
      },
    );
  }
}

class Header extends StatelessWidget {
  final bool isMobile;
  const Header({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final isDark = themeModeNotifier.value == ThemeMode.dark;
    final theme = Theme.of(context);

    if (isMobile) {
      // Mobile Header
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Text(
                'MW',
                style: theme.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: <Color>[Colors.purpleAccent, Colors.blueAccent],
                    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                ),
              ),
            ),
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
      );
    }
    // Desktop/Tablet Header
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
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ),
      );
    }).toList();
  }
}

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final navItems = ['Overview', 'Stack', 'Experience', 'Projects', 'Contact'];

    return Drawer(
      child: Container(
        color: theme.scaffoldBackgroundColor,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            ...navItems.map((item) {
              return ListTile(
                title: Text(item, style: theme.textTheme.bodyLarge),
                onTap: () {
                  // TODO: Implement navigation logic
                  Navigator.of(context).pop(); // Close the drawer
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
