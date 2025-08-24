import 'package:flutter/material.dart';
import 'package:porfolio/sections/home_page.dart';
import 'package:porfolio/routes/route_name.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(builder: (_) => const Homepage());
      // Add more routes here using RouteName constants
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
