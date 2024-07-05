import 'package:ams/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../model/user.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {

  String _month = DateFormat('MMMM').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          
            padding: const EdgeInsets.only(top:20,left: 20,right: 20),
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
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _month,
                        style: TextStyle(
                          fontSize: deviceWidth(context) / 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final month = await showMonthYearPicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2024),
                              lastDate: DateTime(2030),
                            builder: (context,child){
                                return Theme(data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: primary,
                                    secondary: primary,
                                    onSecondary: Colors.white,
                                  ),
                                  textButtonTheme:TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      foregroundColor: primary,
                                    )
                                  ),
                                  textTheme: const TextTheme(

                                  ),
                                ), child: child!, );
                            }
                          );
                          if(month!=null){
                            setState(() {
                            _month =  DateFormat("MMMM").format(month);
                            });
                          }
                        },
                        child: Text(
                          "Pick a month",
                          style: TextStyle(
                            fontSize: deviceWidth(context) / 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: deviceHeight(context) / 1.4,
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
                            physics: const BouncingScrollPhysics(),
                            itemCount: snap.length,
                            itemBuilder: (context, index) {
                              return DateFormat('MMMM').format(
                                          snap[index]['date'].toDate()) ==
                                      _month
                                  ?
                                  // --------------Calender Tile-------------
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      margin:  EdgeInsets.only(
                                        top: index > 0 ? 12:0 ,
                                          bottom: 18, left: 6, right: 6),
                                      height: deviceHeight(context) * .17,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 10,
                                                offset: Offset(2, 2))
                                          ],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                              child: Container(
                                            margin: const EdgeInsets.only(),
                                            decoration: BoxDecoration(
                                                color: primary,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(20))),
                                            child: Center(
                                              child: Text(
                                                DateFormat('EE\n  dd').format(
                                                    snap[index]['date']
                                                        .toDate()),
                                                style: TextStyle(
                                                  fontSize:
                                                      deviceWidth(context) / 20,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
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
                                                        deviceWidth(context) /
                                                            25,
                                                    color: const Color.fromARGB(
                                                        255, 83, 83, 83)),
                                              ),
                                              Text(
                                                snap[index]['checkIn'],
                                                style: TextStyle(
                                                    fontSize:
                                                        deviceWidth(context) /
                                                            20),
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
                                                        deviceWidth(context) /
                                                            25,
                                                    color: const Color.fromARGB(
                                                        255, 83, 83, 83)),
                                              ),
                                              Text(
                                                snap[index]['checkOut'],
                                                style: TextStyle(
                                                    fontSize:
                                                        deviceWidth(context) /
                                                            20),
                                              )
                                            ],
                                          ))
                                        ],
                                      ),
                                    )
                                  : const SizedBox();
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
