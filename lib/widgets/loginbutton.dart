// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ams/constant.dart';

class Loginbutton extends StatelessWidget {
  final Function function;
  const Loginbutton({
    super.key,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: deviceHeight(context) * .04),
      child: SizedBox(
        width: double.infinity,
        height: deviceHeight(context) * .07,
        child: ElevatedButton(
          onPressed: () {
            function();
          },
          style: ButtonStyle(
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
            backgroundColor: WidgetStatePropertyAll(primary),
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}


