import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: Colors.white,
      ),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            focusedBorder:  OutlineInputBorder(
              borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 255)),borderRadius: BorderRadius.circular(10)
            ),
            fillColor: const Color.fromARGB(255, 0, 0, 0),
            filled: true,
            hintText: hintText,
            focusColor: Colors.white,
            hintStyle: TextStyle(color: Color.fromARGB(255, 135, 132, 132))));
  }
}
