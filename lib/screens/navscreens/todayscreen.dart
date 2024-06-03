import 'package:ams/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../model/user.dart';

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
                  color: primary,
                  letterSpacing: 2,
                  fontSize: deviceWidth(context) * .05),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Employee ${User.username}",
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
                        "Check Out",
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
                    text: "${DateTime.now().day} ",
                    style: TextStyle(
                        color: primary, fontSize: deviceWidth(context) / 18),
                    children: [
                      TextSpan(
                          text: DateFormat('MMMM yyyy').format(DateTime.now()),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Nexa'))
                    ]),
              )),
          StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${DateFormat('hh:mm:ss a').format(DateTime.now())}",
                    style: TextStyle(
                        fontSize: deviceWidth(context) / 20,
                        color: Colors.black54),
                  ),
                );
              }),
          Container(
            margin: EdgeInsets.only(top: deviceHeight(context) / 20),
            child: Builder(builder: (context) {
              final GlobalKey<SlideActionState> key = GlobalKey();
              return SlideAction(
                innerColor: primary,
                outerColor: Colors.white,
                height: deviceHeight(context) * 0.075,
                elevation: 5,
                animationDuration: Duration(milliseconds: 500),
                text: "Slide to Check In",
                textStyle: TextStyle(
                    color: Colors.black54, fontSize: deviceWidth(context) / 20),
                key: key,
                onSubmit: () async {
                  CollectionReference colref =
                      FirebaseFirestore.instance.collection('Employee');
                  print(DateFormat('hh:mm').format(DateTime.now()));
                  QuerySnapshot snap =
                      await colref.where('id', isEqualTo: User.username).get();
                  print(snap.docs[0].id);
                  print(DateFormat('MMMM yyyy').format(DateTime.now()));
                  DocumentSnapshot snap2 = await colref.doc(snap.docs[0].id).collection('Record').doc(DateFormat('dd MMMM YYYY').format(DateTime.now())).get();
                  print(snap2['checkIn']);
                  await colref
                      .doc(snap.docs[0].id)
                      .collection("Record")
                      .doc(DateFormat('MMMM yyyy').format(DateTime.now()))
                      .update({
                    'checkIn': DateFormat('hh:mm').format(DateTime.now())
                  });
                  // await
                },
              );
            }),
          )
        ],
      ),
    ));
  }
}
