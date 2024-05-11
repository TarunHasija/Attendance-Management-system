// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ams/constant.dart';
import 'package:ams/responsive/mobile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Responsive extends StatefulWidget {
  Widget mobileScreen;
  Widget webScreen;

  Responsive({
    Key? key,
    required this.mobileScreen,
    required this.webScreen,
  }) : super(key: key);

  @override
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 900) {
        isMobile = true;
        isWeb = false;
        return widget.mobileScreen;
      } else {
        isMobile = false;
        isWeb = true;
        return widget.webScreen;
      }
    });
  }
}
