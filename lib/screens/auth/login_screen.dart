import 'package:ams/constant.dart';
import 'package:ams/widgets/input_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: isWeb?width/4:width/ 1.2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Login Screen",style: TextStyle(fontSize: 25),),
                SizedBox(height: 35,),
                InputField(hintText: "Email", controller: _emailController),
                SizedBox(
                  height: 25,
                ),
                InputField(hintText: "Password", controller: _passwordController),
                SizedBox(height: 25,),
                ElevatedButton(onPressed: (){}, child: Text("Login"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
