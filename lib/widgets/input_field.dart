import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  const InputField({required this.hintText,required this.controller, super.key});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          fillColor: Colors.grey.shade100,
          filled: true,
          hintText: widget.hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }
}
