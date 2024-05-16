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
                        gradient: primary,
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
                            hintText: "Enter  Password",
                            controller: passController,
                            iconn: const Icon(Icons.lock_open_outlined),
                          ),
                          Loginbutton(
                            function: () async {
                              String id = idController.text.trim();
                              String password = passController.text.trim();
                              QuerySnapshot snapshot =
                                  await collectionReference.get();
                              print(snapshot.docs[0]['id']);
        
                              if (id.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Employee id is Empty")));
                              }
                              if (password.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Employee password is Empty")));
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
