import 'package:flutter/material.dart';

double deviceHeight(BuildContext context) =>
    MediaQuery.of(context as BuildContext).size.height;
double deviceWidth(BuildContext context) =>
    MediaQuery.of(context as BuildContext).size.width;

Color primary = Color.fromARGB(248, 28, 149, 255);
