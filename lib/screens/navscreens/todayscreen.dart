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
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 32),
            child: Text("Welcome",style: TextStyle(
              color: Colors.black54,
              letterSpacing: 2,
              fontSize: deviceWidth(context)*.05
              
            ),),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text("Employee",style: TextStyle(
              letterSpacing: 2,
              fontSize: deviceWidth(context)*.06
              
            ),),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 32),
            child: Text("Today's Status",style: TextStyle(
              letterSpacing: 2,
              fontSize: deviceWidth(context)*.05
              
            ),),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(2, 2)
                )
              ]
            ),
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 32),
            child: Text("Today's Status",style: TextStyle(
              letterSpacing: 2,
              fontSize: deviceWidth(context)*.05
              
            ),),
          ),
        ],
      ),
    ));
  }
}
