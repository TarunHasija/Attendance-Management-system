import 'package:ams/constant.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: deviceHeight(context) / 2.5,
            width: deviceWidth(context),
            decoration: BoxDecoration(
                color: primary,
                borderRadius:
                    const BorderRadius.only(bottomRight: Radius.circular(35))),
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
                top: deviceHeight(context) / 15,
                bottom: deviceHeight(context) / 20),
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
                  Text(
                    "Employee ID",
                    style: TextStyle(fontSize: deviceWidth(context) / 26),
                  ),
                  SizedBox(
                    height: deviceHeight(context) * .01,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(2, 2))
                      ],
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: deviceWidth(context) / 26),
                          width: deviceWidth(context) / 15,
                          child: Icon(
                            Icons.person,
                            color: primary,
                            size: deviceWidth(context) / 13,
                          ),
                        ),
                        Expanded(
                            child: TextFormField(
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: deviceHeight(context) / 35),
                              border: InputBorder.none,
                              hintText: "Enter Employee Id"),
                        ))
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
