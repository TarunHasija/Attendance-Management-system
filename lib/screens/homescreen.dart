import 'package:ams/constant.dart';
import 'package:ams/screens/navscreens/calenderscreen.dart';
import 'package:ams/screens/navscreens/profilescreen.dart';
import 'package:ams/screens/navscreens/todayscreen.dart';
import 'package:ams/services/location_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../model/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int currentIndex = 0;
String id = '';

class _HomeScreenState extends State<HomeScreen> {
  List<IconData> navigationIcons = [
    FontAwesomeIcons.check,
    FontAwesomeIcons.calendar,
    FontAwesomeIcons.user,
  ];
  @override
  void initState() {
    super.initState();
    _startLocationService();
    getId().then((value){
      _getCredentials();
      _getProfilePic();
    });

  }

  void _getCredentials()async{
    try{
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('Employee').doc(User.id).get();
      setState(() {
        User.canEdit = doc['canEdit'];
        User.firstName = doc['firstName'];
        User.lastName = doc['lastName'];
        User.address = doc['address'];
        User.birthDate = doc['birthDate'];

      });
    }
    catch(e){
      return;
    }

  }  void _getProfilePic()async{
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('Employee').doc(User.id).get();
    setState(() {
      User.profilePicLink = doc['profilePic'];

    });

  }

  void _startLocationService() async {
    LocationService().initialize();
    LocationService().getLongitute().then((value) {
      setState(() {
        User.long = value!;
      });

      LocationService().getLatitude().then((value) {
        setState(() {
          User.lat = value!;
        });
      });
    });
  }

  Future<void>getId() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('Employee')
        .where('id', isEqualTo: User.employeeId)
        .get();

    setState(() {
      User.id = snap.docs[0].id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          TodayScreen(),
          CalenderScreen(),
          ProfileScreen(),
        ],
      ),
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
                child: SizedBox(
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
                      i == currentIndex
                          ? Container(
                              margin: const EdgeInsets.only(top: 6),
                              height: deviceHeight(context) * .006,
                              width: deviceWidth(context) * 0.05,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                color: primary,
                              ),
                            )
                          : const SizedBox(),
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
