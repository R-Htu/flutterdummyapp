import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final controller;
  final String hinText;
  final bool obscureText;

  const MyTextfield(
      {super.key,
      required this.controller,
      required this.hinText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color.fromARGB(255, 83, 50, 50),
            ),
          ),
          fillColor: const Color.fromARGB(255, 252, 242, 242),
          filled: true,
          hintText: hinText,
          hintStyle: TextStyle(
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }
}
