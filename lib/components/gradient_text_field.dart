import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

// ? GradientTextFieldComponent == custom text field widget with a gradient border

// * ---------------- * (STATELESS WIDGET) CLASS GradientTextFieldComponent (STATELESS WIDGET) * ---------------- *
class GradientTextFieldComponent extends StatelessWidget {
  // ? Component variables
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final double width;
  final EdgeInsetsGeometry padding;

  // ? Required variables to be passed
  const GradientTextFieldComponent({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.width,
    required this.padding,
  });

  // * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: Container(
          width: width,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(252, 250, 245, 1),
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(25)),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              border: GradientOutlineInputBorder(
                gradient: const LinearGradient(colors: [
                  Color.fromRGBO(209, 147, 246, 1),
                  Color.fromRGBO(115, 142, 247, 1),
                  Color.fromRGBO(116, 215, 247, 1)
                ]),
                width: 2,
                borderRadius: BorderRadius.circular(25),
              ),
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
// * ---------------- * END OF (STATELESS WIDGET) CLASS GradientTextFieldComponent (STATELESS WIDGET) * ---------------- *
