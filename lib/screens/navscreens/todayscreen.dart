import 'package:ams/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

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
            child: Text(
              "Welcome",
              style: TextStyle(
                  color:primary,
                  letterSpacing: 2,
                  fontSize: deviceWidth(context) * .05),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Employee",
              style: TextStyle(
                  letterSpacing: 2, fontSize: deviceWidth(context) * .06),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 32),
            child: Text(
              "Today's Status",
              style: TextStyle(
                  letterSpacing: 2, fontSize: deviceWidth(context) * .05),
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 12, bottom: 32),
              height: deviceHeight(context) * .2,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 2))
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Check in",
                        style: TextStyle(
                            fontSize: deviceWidth(context) / 20,
                            color: const Color.fromARGB(255, 83, 83, 83)),
                      ),
                      Text(
                        "09:30",
                        style: TextStyle(fontSize: deviceWidth(context) / 18),
                      )
                    ],
                  )),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Check out",
                        style: TextStyle(
                            fontSize: deviceWidth(context) / 20,
                            color: const Color.fromARGB(255, 83, 83, 83)),
                      ),
                      Text(
                        "--/--",
                        style: TextStyle(fontSize: deviceWidth(context) / 18),
                      )
                    ],
                  ))
                ],
              )),
          Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                    text: "11",
                    style: TextStyle(
                        color: primary, fontSize: deviceWidth(context) / 18),
                    children: const [
                      TextSpan(
                          text: "Jan 2024",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Nexa'))
                    ]),
              )),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "12:30:00 PM",
              style: TextStyle(
                  fontSize: deviceWidth(context) / 20, color: Colors.black54),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top:deviceHeight(context)/20),
            child: Builder(builder: (context) {
              final GlobalKey<SlideActionState> key = GlobalKey();
              return  SlideAction(
                innerColor: primary,
                outerColor: Colors.white,
                borderRadius: CupertinoCheckbox.width,
                text: "Slide to Check In",

                textStyle:  TextStyle(
                  color: Colors.black54,
                  fontSize: deviceWidth(context)/20
                ),
                key: key,
                onSubmit: (){
                  key.currentState!.reset();
                },
              );
            }),
          )
        ],
      ),
    ));
  }
}
