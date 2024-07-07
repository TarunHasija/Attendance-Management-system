import 'dart:js_interop';

import 'package:ams/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String birth = "Date of Birth";
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 80, bottom: 20),
              height: 120,
              width: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: primary,
              ),
              child: Center(
                child: Icon(
                  Icons.person,
                  size: deviceHeight(context) / 15,
                  color: Colors.white,
                ),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  "Employee ${User.employeeId}",
                  style: const TextStyle(fontSize: 18),
                )),
            const SizedBox(
              height: 50,
            ),
            textField("First Name", "First Name", firstNameController),
            textField("Last Name", "Last Name", lastNameController),

            //------------Date of Birth Field--------------------
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Date of Birth",
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: GestureDetector(
                onTap: () => {
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: primary,
                              secondary: primary,
                              onSecondary: Colors.white,
                            ),
                            textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                              foregroundColor: primary,
                            )),
                            textTheme: const TextTheme(),
                          ),
                          child: child!,
                        );
                      }).then((value) {
                    setState(() {
                      birth = DateFormat("MM/dd/yyyy").format(value!);
                    });
                  }),
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  height: 65,
                  width: deviceWidth(context),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black54)),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        birth,
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // -------------Date of Birth Field end------------------------
            textField("Address", "Address", addressController),

            //--------------Save Button -----------------------------------
            GestureDetector(
              onTap: () async {
                String firstName = firstNameController.text;
                String lastName = lastNameController.text;
                String address = addressController.text;
                String birthDate = birth;

               if(User.canEdit){
                 if (firstName.isEmpty) {
                   showSnackBar("Please enter first name");
                 } else if (lastName.isEmpty) {
                   showSnackBar("Please enter your last name");
                 } else if (birthDate.isEmpty) {
                   showSnackBar("Please choose your Birth Date");
                 } else if (address.isEmpty) {
                   showSnackBar("Please enter your address");
                 }
                 else {
                   await FirebaseFirestore.instance.collection("Employee").doc(User.id).update({
                     'firstName':firstName,
                     'lastName':lastName,
                     'address':address,
                     'birthDate':birthDate,
                     'canEdit':false,
                   });
                 }
               }
                else{
                  showSnackBar("You can't edit anymore , Please contact Department");
                }
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16, top: 16),
                height: 65,
                width: deviceWidth(context),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black54),
                    color: primary),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textField(
      String hint, String title, TextEditingController controller) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 20, top: 10),
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.black54,
            maxLines: 1,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Colors.black38,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Colors.black54,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.black54))),
          ),
        ),
      ],
    );
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
        content: Text(
      text,
      style: TextStyle(),
    )));
  }
}
