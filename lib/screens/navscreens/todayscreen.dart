import 'dart:async';


import 'package:ams/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  String checkIn = "--/--";
  String checkOut = "--/--";
  @override
  void initState() {
    // TODO: implement initState
    print('hello');
    getRecord();
    super.initState();
  }

  getRecord() async {
    try {
      CollectionReference colref =
          FirebaseFirestore.instance.collection('Employee');
      // print(DateFormat('hh:mm').format(DateTime.now()));
      QuerySnapshot snap =
          await colref.where('id', isEqualTo: User.username).get();
      // print(snap.docs[0].id);
      // print(DateFormat('MMMM yyyy').format(DateTime.now()));
      DocumentSnapshot snap2 = await colref
          .doc(snap.docs[0].id)
          .collection('Record')
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .get();
      setState(() {
        checkIn = snap2['checkIn'];
        checkOut = snap2['checkOut'];
      });
    } catch (e) {
      String checkIn = "--/--";
      String checkOut = "--/--";
    }
    print(checkIn);
    print(checkOut);
  }

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
                        checkIn,
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
                        checkOut,
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
          checkOut == '--/--'
              ? Container(
                  margin: EdgeInsets.only(top: deviceHeight(context) / 20),
                  child: Builder(builder: (context) {
                    final GlobalKey<SlideActionState> key = GlobalKey();
                    return SlideAction(
                        innerColor: primary,
                        outerColor: Colors.white,
                        elevation: 5,
                        animationDuration: const Duration(milliseconds: 500),
                        text: checkIn == '--/--'
                            ? "Slide to Check In"
                            : "Slide to Check out",
                        textStyle: TextStyle(
                            color: Colors.black54,
                            fontSize: deviceWidth(context) / 20),
                        key: key,
                        onSubmit: () async {

                          Timer(Duration(seconds: 1), (){
                            key.currentState!.reset();
                          });



                          CollectionReference colref =
                              FirebaseFirestore.instance.collection('Employee');
                          print(DateFormat('hh:mm').format(DateTime.now()));
                          QuerySnapshot snap = await colref
                              .where('id', isEqualTo: User.username)
                              .get();
                          print(snap.docs[0].id);
                          print(DateFormat('MMMM yyyy').format(DateTime.now()));
                          DocumentSnapshot snap2 = await colref
                              .doc(snap.docs[0].id)
                              .collection('Record')
                              .doc(DateFormat('dd MMMM yyyy')
                                  .format(DateTime.now()))
                              .get();

                          try {
                            String checkIn = snap2['checkIn'];

                            setState(() {
                              checkOut = DateFormat('hh:mm').format(DateTime.now());
                            });

                            await colref
                                .doc(snap.docs[0].id)
                                .collection("Record")
                                .doc(DateFormat('dd MMMM yyyy')
                                    .format(DateTime.now()))
                                .update({
                              'checkIn': checkIn,
                              'checkOut':
                                  DateFormat('hh:mm').format(DateTime.now()),
                            });
                          } catch (e) {
                            setState(() {
                              checkIn = DateFormat('hh:mm').format(DateTime.now());
                            });
                            await colref
                                .doc(snap.docs[0].id)
                                .collection("Record")
                                .doc(DateFormat('dd MMMM yyyy')
                                    .format(DateTime.now()))
                                .set({
                              'checkIn':
                                  DateFormat('hh:mm').format(DateTime.now()),
                              'checkOut':
                                  DateFormat('hh:mm').format(DateTime.now())

                              // 'checkOut':checkOut
                            });
                            // await
                          }
                        });
                  }),
                )
              : Container(
            margin: EdgeInsets.only(top: 32),
                  child: Text("You Have completed the day!!",style: TextStyle(
                    fontSize: deviceWidth(context)/20,
                    color: Colors.black,
                  ),),
                )
        ],
      ),
    ));
  }
}
