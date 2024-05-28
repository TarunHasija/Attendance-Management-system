import 'package:ams/constant.dart';
import 'package:flutter/material.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 32),
            alignment: Alignment.centerLeft,
            child: Text("Welcome",style: TextStyle(
              color: Colors.black54,
              letterSpacing: 2,
              fontSize: deviceWidth(context)/26,
              
            ),),
          )
        ],
      ),
    ));
  }
}
