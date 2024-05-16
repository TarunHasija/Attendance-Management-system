// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ams/constant.dart';

class LoginInputBox extends StatelessWidget {
  final bool obcurseText;
  final Icon iconn;
  final String hintText;
  final TextEditingController controller;

   const LoginInputBox({
    super.key,
    required this.obcurseText,
    required this.iconn,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: deviceHeight(context) / 100),
      child: SizedBox(
        // margin: EdgeInsets.all(10.0),
        width: double.infinity,
        height: deviceHeight(context) * .08,
        child: TextFormField(
          obscureText: obcurseText,
          cursorColor: primary,
          controller: controller,
          decoration: InputDecoration(
              prefixIcon: iconn,
              iconColor: primary,
              labelText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              )),
        ),
      ),
    );
  }
}
