import 'package:ams/responsive/mobile_screen.dart';
import 'package:ams/responsive/responsive.dart';
import 'package:ams/responsive/web_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Responsive(mobileScreen: MobileScreen(), webScreen: WebScreen()));
  }
}
