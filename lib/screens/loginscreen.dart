import 'package:ams/constant.dart';
import 'package:ams/screens/homescreen.dart';
import 'package:ams/widgets/fieldtitle.dart';
import 'package:ams/widgets/inputbox.dart';
import 'package:ams/widgets/loginbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Employee');
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> _login() async {
    FocusScope.of(context).unfocus();
    String id = idController.text.trim();
    String password = passController.text.trim();

    if (id.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Employee id is Empty")));
    } else if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Employee password is Empty")));
    } else {
      try {
        QuerySnapshot snapshot = await collectionReference
            .where('id', isEqualTo: id)
            .get();

        if (snapshot.docs.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Employee id doesn't exist")));
          return;
        }

        bool passwordMatched = false;
        for (var doc in snapshot.docs) {
          if (password == doc['password']) {
            passwordMatched = true;
            break;
          }
        }

        if (passwordMatched) {
          await sharedPreferences.setString('Employeeid', id);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomeScreen()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Password is not correct")));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("An error occurred: ${e.toString()}")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      reverse: true,
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
                        hintText: "Enter Password",
                        controller: passController,
                        iconn: const Icon(Icons.lock_open_outlined),
                      ),
                      Loginbutton(
                        function: _login,
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
