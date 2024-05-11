import 'package:ams/screens/auth/login_screen.dart';
import 'package:ams/screens/auth/signup_screen.dart';
import 'package:ams/widgets/input_field.dart';
import 'package:flutter/material.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  @override
  Widget build(BuildContext context) {
    return SignupScreen();
  }
}
