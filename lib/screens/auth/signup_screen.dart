import 'package:ams/constant.dart';
import 'package:ams/widgets/input_field.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: isWeb ? width / 4 : width / 1.2,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Login Screen",
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 35,
                ),
                InputField(hintText: "Email", controller: _emailController),
                const SizedBox(
                  height: 25,
                ),
                InputField(
                    hintText: "Username", controller: _usernameController),
                const SizedBox(
                  height: 25,
                ),
                InputField(
                    hintText: "Password", controller: _passwordController),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(onPressed: () {}, child: const Text("Sign Up"))
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
