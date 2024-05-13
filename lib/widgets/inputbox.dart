import 'package:flutter/material.dart';
import 'package:ams/constant.dart';

class LoginInputBox extends StatelessWidget {
  final IconData iconn;
  final String hintText;
  final TextEditingController controller;

  const LoginInputBox({
    Key? key,
    required this.iconn,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(66, 86, 86, 86),
            blurRadius: 10,
            offset: Offset(2, 2),
          )
        ],
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: deviceWidth(context) / 26),
            width: deviceWidth(context) / 15,
            child: Icon(
              iconn,
              color: primary,
              size: deviceWidth(context) / 13,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: TextFormField(
                controller: controller,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: deviceHeight(context) / 35,
                  ),
                  border: InputBorder.none,
                  hintText: hintText,
                ),
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
