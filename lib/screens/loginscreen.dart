
import 'package:ams/constant.dart';
import 'package:ams/widgets/fieldtitle.dart';
import 'package:ams/widgets/inputbox.dart';
import 'package:ams/widgets/loginbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController idController = TextEditingController();
TextEditingController passController = TextEditingController();
CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('Employee');

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
      reverse: true,
      // physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                height: deviceHeight(context) / 2.5,
                width: deviceWidth(context),
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(70))),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: deviceWidth(context) / 5,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: deviceHeight(context) / 20,
                    bottom: deviceHeight(context) / 40),
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: deviceWidth(context) / 13),
                ),
              ),

              // !! __________ Employee id and password Input fields___________

              Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: deviceWidth(context) / 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FieldTitle(
                        title: "Employee Id",
                      ),
                      LoginInputBox(
                        obcurseText: false,
                        hintText: "Enter Employee Id",
                        controller: idController,
                        iconn: const Icon(Icons.person),
                      ),
                      SizedBox(
                        height: deviceHeight(context) * .02,
                      ),
                      const FieldTitle(
                        title: "Password",
                      ),
                      LoginInputBox(
                        obcurseText: true,
                        hintText: "Enter  Password",
                        controller: passController,
                        iconn: const Icon(Icons.lock_open_outlined),
                      ),
                      Loginbutton(
// !!------------- Function for login -----------------
                        function: () async {
                          FocusScope.of(context).unfocus();
                          String id = idController.text.trim();
                          String password = passController.text.trim();

                          if (id.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Employee id is Empty")));
                          } else if (password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Employee password is Empty")));
                          } else {
                            QuerySnapshot snapshot = await collectionReference
                                .where('id', isEqualTo: id)
                                .get();
                            try {
                              if (password == snapshot.docs[0]['password']) {
                                print("continue");
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("password is not correct")));
                              }
                            } catch (e) {
                              String error = '';

                              if (e.toString() ==
                                  "RangeError (index): Invalid value: Valid value range is smpty: 0 ") {
                                setState(() {
                                  error = "Employee id doesnt exist";
                                });
                              } else {
                                error = "Error occurred";
                              }

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(error)));
                            }
                          }
                        },
                      )
                    ],
                  )),
            ],
          ),
        ],
      ),
    ));
  }
}
