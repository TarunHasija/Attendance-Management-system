import 'package:ams/constant.dart';
import 'package:flutter/material.dart';

class FieldTitle extends StatelessWidget {
  final String title;
  const FieldTitle({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: deviceHeight(context) * 0.01),
      child: Text(
        title,
        style: TextStyle(fontSize: deviceWidth(context) / 26),
      ),
    );
  }
}