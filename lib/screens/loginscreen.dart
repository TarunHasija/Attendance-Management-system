import 'package:ams/constant.dart';
import 'package:ams/widgets/fieldtitle.dart';
import 'package:ams/widgets/inputbox.dart';
import 'package:ams/widgets/loginbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
  bool iskeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);
  TextEditingController idController = TextEditingController();
  TextEditingController passController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            height: deviceHeight(context) / 2.5,
            width: deviceWidth(context),
            decoration: BoxDecoration(
                color: primary,
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(70))),
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
              iskeyboardVisible ?"Login":"Key",
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
                    iconn: Icons.person,
                  ),
                  SizedBox(
                    height: deviceHeight(context)*.02,
                  ),
                  const FieldTitle(
                    title: "Password",
                  ),
                  LoginInputBox(
                    hintText: "Enter  Password",
                    controller: passController,
                    iconn: Icons.lock_open_outlined,
                  ),

                  Loginbutton(function: (){},)
                ],
              )),
        ],
      ),
    );
  }
}


