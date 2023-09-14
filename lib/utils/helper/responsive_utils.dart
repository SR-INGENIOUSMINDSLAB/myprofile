import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double getWidth(double width) {
  return width.w;
}

double getHeight(double height) {
  return height.h;
}

double getFontSize(double fontSize) {
  return fontSize.sp;
}

double getRadius(double radius) {
  return radius.r;
}

Size getDesignSize(context) {
  if (Responsive.isDesktop(context)) {
    return const Size(1920, 1080);
  } else if (Responsive.isMobile(context)) {
    return const Size(360, 690);
  } else {
    return const Size(768, 1024);
  }
}

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // If our width is more than 1100 then we consider it a desktop
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1100) {
          return desktop;
        }
        // If width it less then 1100 and more then 650 we consider it as tablet
        else if (constraints.maxWidth >= 650) {
          return tablet;
        }
        // Or less then that we called it mobile
        else {
          return mobile;
        }
      },
    );
  }
}
