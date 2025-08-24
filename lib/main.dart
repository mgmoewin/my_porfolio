import 'package:flutter/material.dart';
import 'package:porfolio/routes/app_router.dart';
import 'package:porfolio/styles/theme.dart';

void main() {
  runApp(const MyPortfolio());
}

final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(
  ThemeMode.light,
);

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeModeNotifier,
      builder: (context, themeMode, child) {
        return MaterialApp(
          title: 'Moe Win\'s Portfolio',
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          initialRoute: '/',
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}
