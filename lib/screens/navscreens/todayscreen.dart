import 'dart:async';

import 'package:ams/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../model/user.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  String checkIn = "--/--";
  String checkOut = "--/--";
  String location = " ";
  String scanResult = " ";
  String officeCode = " ";
  @override
  void initState() {
    super.initState();
    _getRecord();
    _getOfficeCode();
  }

  void _getOfficeCode()async{
    DocumentSnapshot snap = await FirebaseFirestore.instance.
    collection("Attributes").doc("Office1").get();
    setState(() {
      officeCode = snap['code'];
    });
  }

  Future<void> scanQRandCheck() async {
    String result = " ";
    try {
      result = await FlutterBarcodeScanner.scanBarcode(
          "ffffff", "cancel", false, ScanMode.QR);
    } catch (e) {
      print(e);
    }

    setState(() {
      scanResult = result;
    });

    if(scanResult == officeCode){
      CollectionReference colref =
      FirebaseFirestore.instance.collection('Employee');
      if (User.lat != 0) {
        _getLocation();
        QuerySnapshot snap = await colref
            .where('id', isEqualTo: User.employeeId)
            .get();

        if (snap.docs.isNotEmpty) {
          DocumentSnapshot snap2 = await colref
              .doc(snap.docs[0].id)
              .collection('Record')
              .doc(DateFormat('dd MMMM yyyy')
              .format(DateTime.now()))
              .get();

          try {
            String checkIn = snap2['checkIn'];

            setState(() {
              checkOut = DateFormat('hh:mm')
                  .format(DateTime.now());
            });

            await colref
                .doc(snap.docs[0].id)
                .collection("Record")
                .doc(DateFormat('dd MMMM yyyy')
                .format(DateTime.now()))
                .update({
              'date': Timestamp.now(),
              'checkIn': checkIn,
              'checkOut': DateFormat('hh:mm')
                  .format(DateTime.now()),
              'checkInLocation': location,
            });
          } catch (e) {
            setState(() {
              checkIn = DateFormat('hh:mm')
                  .format(DateTime.now());
            });
            await colref
                .doc(snap.docs[0].id)
                .collection("Record")
                .doc(DateFormat('dd MMMM yyyy')
                .format(DateTime.now()))
                .set({
              'date': Timestamp.now(),
              'checkIn': DateFormat('hh:mm')
                  .format(DateTime.now()),
              'checkOut': "--/--",
              'checkOutLocation': location,
            });
          }


        } else {
          // Handle the case when there are no documents
        }
      } else {
        Timer(const Duration(seconds: 3), () async {
          _getLocation();
          QuerySnapshot snap = await colref
              .where('id', isEqualTo: User.employeeId)
              .get();

          if (snap.docs.isNotEmpty) {
            DocumentSnapshot snap2 = await colref
                .doc(snap.docs[0].id)
                .collection('Record')
                .doc(DateFormat('dd MMMM yyyy')
                .format(DateTime.now()))
                .get();

            try {
              String checkIn = snap2['checkIn'];

              setState(() {
                checkOut = DateFormat('hh:mm')
                    .format(DateTime.now());
              });

              await colref
                  .doc(snap.docs[0].id)
                  .collection("Record")
                  .doc(DateFormat('dd MMMM yyyy')
                  .format(DateTime.now()))
                  .update({
                'date': Timestamp.now(),
                'checkIn': checkIn,
                'checkOut': DateFormat('hh:mm')
                    .format(DateTime.now()),
                'checkInLocation': location,
              });
            } catch (e) {
              setState(() {
                checkIn = DateFormat('hh:mm')
                    .format(DateTime.now());
              });
              await colref
                  .doc(snap.docs[0].id)
                  .collection("Record")
                  .doc(DateFormat('dd MMMM yyyy')
                  .format(DateTime.now()))
                  .set({
                'date': Timestamp.now(),
                'checkIn': DateFormat('hh:mm')
                    .format(DateTime.now()),
                'checkOut': "--/--",
                'checkOutLocation': location,
              });
            }


          } else {
            // Handle the case when there are no documents
          }
        });
      }
    }
  }

  void _getLocation() async {
    List<Placemark> placeMark =
        await placemarkFromCoordinates(User.lat, User.long);

    setState(() {
      location =
          "${placeMark[0].street} , ${placeMark[0].administrativeArea} , ${placeMark[0].postalCode} , ${placeMark[0].country}";
    });
  }

  _getRecord() async {
    try {
      CollectionReference colref =
          FirebaseFirestore.instance.collection('Employee');

      QuerySnapshot snap =
          await colref.where('id', isEqualTo: User.employeeId).get();

      if (snap.docs.isNotEmpty) {
        DocumentSnapshot snap2 = await colref
            .doc(snap.docs[0].id)
            .collection('Record')
            .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
            .get();

        setState(() {
          checkIn = snap2['checkIn'];
          checkOut = snap2['checkOut'];
        });
      } else {
        // Handle the case when there are no documents
        setState(() {
          checkIn = "--/--";
          checkOut = "--/--";
        });
      }
    } catch (e) {
      setState(() {
        checkIn = "--/--";
        checkOut = "--/--";
      });
    }
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
              "Employee ${User.employeeId}",
              style: TextStyle(
                  letterSpacing: 2, fontSize: deviceWidth(context) * .06),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: deviceHeight(context) / 30),
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
                              fontFamily: 'Poppins'))
                    ]),
              )),
          StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateFormat('hh:mm:ss a').format(DateTime.now()),
                    style: TextStyle(
                        fontSize: deviceWidth(context) / 20,
                        color: Colors.black54),
                  ),
                );
              }),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 32),
            child: Text(
              "Today's Status",
              style: TextStyle(
                  letterSpacing: 1.5, fontSize: deviceWidth(context) * .06),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 30, bottom: 32),
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
            ),
          ),
          checkOut == '--/--'
              ? Container(
                  margin: EdgeInsets.only(top: deviceHeight(context) *0.015,bottom: deviceHeight(context)*0.04),
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
                          CollectionReference colref =
                              FirebaseFirestore.instance.collection('Employee');
                          if (User.lat != 0) {
                            _getLocation();
                            QuerySnapshot snap = await colref
                                .where('id', isEqualTo: User.employeeId)
                                .get();

                            if (snap.docs.isNotEmpty) {
                              DocumentSnapshot snap2 = await colref
                                  .doc(snap.docs[0].id)
                                  .collection('Record')
                                  .doc(DateFormat('dd MMMM yyyy')
                                      .format(DateTime.now()))
                                  .get();

                              try {
                                String checkIn = snap2['checkIn'];

                                setState(() {
                                  checkOut = DateFormat('hh:mm')
                                      .format(DateTime.now());
                                });

                                await colref
                                    .doc(snap.docs[0].id)
                                    .collection("Record")
                                    .doc(DateFormat('dd MMMM yyyy')
                                        .format(DateTime.now()))
                                    .update({
                                  'date': Timestamp.now(),
                                  'checkIn': checkIn,
                                  'checkOut': DateFormat('hh:mm')
                                      .format(DateTime.now()),
                                  'checkInLocation': location,
                                });
                              } catch (e) {
                                setState(() {
                                  checkIn = DateFormat('hh:mm')
                                      .format(DateTime.now());
                                });
                                await colref
                                    .doc(snap.docs[0].id)
                                    .collection("Record")
                                    .doc(DateFormat('dd MMMM yyyy')
                                        .format(DateTime.now()))
                                    .set({
                                  'date': Timestamp.now(),
                                  'checkIn': DateFormat('hh:mm')
                                      .format(DateTime.now()),
                                  'checkOut': "--/--",
                                  'checkOutLocation': location,
                                });
                              }

                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (key.currentState != null) {
                                  key.currentState?.reset();
                                }
                              });
                            } else {
                              // Handle the case when there are no documents
                            }
                          } else {
                            Timer(const Duration(seconds: 3), () async {
                              _getLocation();
                              QuerySnapshot snap = await colref
                                  .where('id', isEqualTo: User.employeeId)
                                  .get();

                              if (snap.docs.isNotEmpty) {
                                DocumentSnapshot snap2 = await colref
                                    .doc(snap.docs[0].id)
                                    .collection('Record')
                                    .doc(DateFormat('dd MMMM yyyy')
                                        .format(DateTime.now()))
                                    .get();

                                try {
                                  String checkIn = snap2['checkIn'];

                                  setState(() {
                                    checkOut = DateFormat('hh:mm')
                                        .format(DateTime.now());
                                  });

                                  await colref
                                      .doc(snap.docs[0].id)
                                      .collection("Record")
                                      .doc(DateFormat('dd MMMM yyyy')
                                          .format(DateTime.now()))
                                      .update({
                                    'date': Timestamp.now(),
                                    'checkIn': checkIn,
                                    'checkOut': DateFormat('hh:mm')
                                        .format(DateTime.now()),
                                    'checkInLocation': location,
                                  });
                                } catch (e) {
                                  setState(() {
                                    checkIn = DateFormat('hh:mm')
                                        .format(DateTime.now());
                                  });
                                  await colref
                                      .doc(snap.docs[0].id)
                                      .collection("Record")
                                      .doc(DateFormat('dd MMMM yyyy')
                                          .format(DateTime.now()))
                                      .set({
                                    'date': Timestamp.now(),
                                    'checkIn': DateFormat('hh:mm')
                                        .format(DateTime.now()),
                                    'checkOut': "--/--",
                                    'checkOutLocation': location,
                                  });
                                }

                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  if (key.currentState != null) {
                                    key.currentState?.reset();
                                  }
                                });
                              } else {
                                // Handle the case when there are no documents
                              }
                            });
                          }
                        });
                  }),
                )
              : Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    "You Have completed the day!!",
                    style: TextStyle(
                      fontSize: deviceWidth(context) / 20,
                      color: Colors.black,
                    ),
                  ),
                ),
          location != " "
              ? Center(
                  child: Padding(
                    padding:  EdgeInsets.only(bottom: deviceHeight(context)*.03),
                    child: Container(
                        // width: double.infinity,
                        height: deviceHeight(context) * 0.1,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(2, 2))
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: Text("Location :$location",)),
                            ],
                          ),
                        )),
                  ),
                )
              : const SizedBox(),


          // ------------- Qr Code checkin and checkOut -------------------
          checkIn =="--/--" && checkOut =="--/--" ?GestureDetector(
            onTap: (){
              scanQRandCheck();
            },
            child: Container(
              height: deviceWidth(context)/2.5,
              width: deviceWidth(context)/2.5,
              decoration:  const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(2, 2))
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.qr_code_scanner_rounded,
                  size: deviceWidth(context)*0.15,
                  color: primary,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Text(
                      checkIn == "--/--"?
                      "Scan to\nCheck In":"Scan to\nCheck Out",
                      style: TextStyle(
                        fontSize: deviceWidth(context)/24,
                        color: Colors.black54
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ):const SizedBox(),
        ],
      ),
    ));
  }
}
