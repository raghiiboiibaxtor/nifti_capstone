import 'package:flutter/material.dart';

// ? TextFieldComponent == custom text field widget

// * ---------------- * (STATELESS WIDGET) CLASS TextFieldComponent (STATELESS WIDGET) * ---------------- *
class TextFieldComponent extends StatelessWidget {
  // Component Variables
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  // Required variables to be passed
  const TextFieldComponent({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  // * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(252, 250, 245, 1),
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(25)),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
            ),
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ));
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATELESS WIDGET) CLASS TextFieldComponent (STATELESS WIDGET) * ---------------- *
