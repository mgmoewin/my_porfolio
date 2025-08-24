import 'package:flutter/widgets.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext, ScreenSizeCategory) builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenSizeCategory screenSize = getScreenSize(constraints.maxWidth);
        return builder(context, screenSize);
      },
    );
  }

  ScreenSizeCategory getScreenSize(double width) {
    if (width < ScreenSize.smallMobile) {
      return ScreenSizeCategory.smallMobile;
    } else if (width < ScreenSize.mobile) {
      return ScreenSizeCategory.mobile;
    } else if (width < ScreenSize.tablet) {
      return ScreenSizeCategory.tablet;
    } else if (width < ScreenSize.laptop) {
      return ScreenSizeCategory.laptop;
    } else {
      return ScreenSizeCategory.desktop;
    }
  }
}

enum ScreenSizeCategory { smallMobile, mobile, tablet, laptop, desktop }

class ScreenSize {
  static const double smallMobile = 350;
  static const double mobile = 750;
  static const double tablet = 900;
  static const double laptop = 1200;
}
