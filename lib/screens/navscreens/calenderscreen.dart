import 'package:ams/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/user.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
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
                    "My Attendance",
                    style: TextStyle(
                      fontSize: deviceWidth(context) / 18,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 32),
                      child: Text(
                        DateFormat("MMMM").format(DateTime.now()),
                        style: TextStyle(
                          fontSize: deviceWidth(context) / 18,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 32),
                      child: Text(
                        "Pick a month",
                        style: TextStyle(
                          fontSize: deviceWidth(context) / 18,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: deviceHeight(context) / 1.5,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Employee")
                          .doc(User.id)
                          .collection('Record')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          final snap = snapshot.data!.docs;
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: snap.length,
                            itemBuilder: (context, index) {
                              return Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(
                                    bottom: 22, left: 6, right: 6),
                                height: deviceHeight(context) * .17,
                                decoration:  const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10,
                                          offset: Offset(2, 2))
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Container(
                                        margin:EdgeInsets.only(),
                                      decoration:  BoxDecoration(
                                        color:primary,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),

                                        child: Center(
                                          child: Text(
                                              snap[index]['date'].toString(),
                                          ),
                                        ),
                                        )),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Check in",
                                          style: TextStyle(
                                              fontSize:
                                                  deviceWidth(context) / 20,
                                              color: const Color.fromARGB(
                                                  255, 83, 83, 83)),
                                        ),
                                        Text(
                                          snap[index]['checkIn'],
                                          style: TextStyle(
                                              fontSize:
                                                  deviceWidth(context) / 18),
                                        )
                                      ],
                                    )),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Check Out",
                                          style: TextStyle(
                                              fontSize:
                                                  deviceWidth(context) / 20,
                                              color: const Color.fromARGB(
                                                  255, 83, 83, 83)),
                                        ),
                                        Text(
                                          snap[index]['checkOut'],
                                          style: TextStyle(
                                              fontSize:
                                                  deviceWidth(context) / 18),
                                        )
                                      ],
                                    ))
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                )
              ],
            )));
  }
}
