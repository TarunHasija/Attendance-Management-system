import 'package:flutter/material.dart';

double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

LinearGradient primary = const LinearGradient(
  colors: [Color.fromARGB(255, 15, 46, 86), Color.fromARGB(255, 43, 124, 230), Color(0xff2d9ee0)],
  stops: [0, 0.5, 1],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

Color bluee = Colors.blue;
