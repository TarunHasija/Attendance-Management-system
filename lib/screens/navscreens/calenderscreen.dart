
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
    return  Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 32),
              child:Text(
                "My Attendance"
                    ,style: TextStyle(
                fontSize: deviceWidth(context)/18,
              ),
              ) ,
            ),
            Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 32),
                  child:Text(
                    DateFormat("MMMM").format(DateTime.now())
                    ,style: TextStyle(
                    fontSize: deviceWidth(context)/18,
                  ),
                  ) ,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(top: 32),
                  child:Text(
                    "Pick a month"
                    ,style: TextStyle(
                    fontSize: deviceWidth(context)/18,
                  ),
                  ) ,
                ),
              ],
            ),
            Container(
              height: deviceHeight(context)- deviceHeight(context)/5,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("Employee").doc(User.id).collection('Record').snapshots(),
                builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.hasData){
                    final snap = snapshot.data!.docs;
                    return ListView.builder(
                    itemCount: snap.length,
                    itemBuilder: (context,index){
                      return Container(
                        child: Text(
                          snap[index]['checkIn']
                        ),
                      );
                    },

                    );
                  }
                  else{
                    return const SizedBox();
                  }
                }
              ),
            )
          ],
        )
      )
    );
  }
}