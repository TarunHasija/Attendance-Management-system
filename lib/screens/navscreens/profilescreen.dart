import 'package:ams/constant.dart';
import 'package:flutter/material.dart';

import '../../model/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String birth = "Date of Birth";
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
            textField("First Name", "First Name"),
            textField("Last Name", "Last Name"),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Date of Birth",
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
            GestureDetector(
              onTap: ()=>{
                showDatePicker(context: context, firstDate: DateTime(1970), lastDate: DateTime(2005))
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: 65,
                width: deviceWidth(context),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black54)),
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      birth,
                      style: const TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            textField("Address", "Address"),
          ],
        ),
      ),
    );
  }
}

Widget textField(String hint, String title) {
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
        margin: const EdgeInsets.only(bottom: 16),
        child: TextFormField(
          cursorColor: Colors.black54,
          maxLines: 1,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              labelText: hint,
              hintStyle: const TextStyle(
                color: Colors.black,
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
