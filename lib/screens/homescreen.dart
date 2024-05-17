import 'package:ams/constant.dart';
import 'package:ams/screens/calenderscreen.dart';
import 'package:ams/screens/profilescreen.dart';
import 'package:ams/screens/todayscreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int currentIndex = 0;

class _HomeScreenState extends State<HomeScreen> {
  List<IconData> navigationIcons = [
    FontAwesomeIcons.calendar,
    FontAwesomeIcons.check,
    FontAwesomeIcons.user,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex,
      children: [
        CalenderScreen(),
        TodayScreen(),
        ProfileScreen(),


      ],),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
            left: deviceWidth(context) * 0.04,
            right: deviceWidth(context) * 0.04,
            bottom: deviceHeight(context) * 0.02),
        height: 70,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(2, 2),
              )
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < navigationIcons.length; i++) ...<Expanded>{
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = i;
                  });
                },
                child: Container(
                  height: deviceHeight(context),
                  width: deviceWidth(context),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        navigationIcons[i],
                        color: i == currentIndex ? primary : Colors.black,
                        size: i == currentIndex
                            ? deviceHeight(context) * 0.03
                            : deviceHeight(context) * 0.025,
                      ),
                  
                      i==currentIndex ? Container(
                        margin: EdgeInsets.only(top: 6),
                        height: deviceHeight(context)*.006,
                        width: deviceWidth(context)*0.05,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                          color: primary,
                        ),
                      ):const SizedBox(),
                    ],
                  )),
                ),
              ))
            }
          ],
        ),
      ),
    );
  }
}
