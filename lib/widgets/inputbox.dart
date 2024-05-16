import 'package:flutter/material.dart';
import 'package:ams/constant.dart';

class LoginInputBox extends StatelessWidget {
  final Icon iconn;
  final String hintText;
  final TextEditingController controller;

  const LoginInputBox({
    super.key,
    required this.iconn,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: deviceHeight(context)/100
      ),
      child: SizedBox(
        // margin: EdgeInsets.all(10.0),
        width: double.infinity,
        height: deviceHeight(context)*.08,
        child:TextFormField(
          cursorColor: bluee,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: iconn,
            iconColor: bluee,
            labelText: hintText,
            border: OutlineInputBorder(
              
              borderRadius: BorderRadius.circular(15.0),
              
            )
            
          ),
        
        ) ,
      ),
    );
  }
}
