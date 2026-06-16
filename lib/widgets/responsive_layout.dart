import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;

  const ResponsiveLayout({
    Key? key, 
    required this.mobileBody, 
    required this.desktopBody
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Threshold 768px sesuai standar tablet/desktop umum
        if (constraints.maxWidth < 768) {
          return mobileBody;
        } else {
          return desktopBody;
        }
      },
    );
  }
}