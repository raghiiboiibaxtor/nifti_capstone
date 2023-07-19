import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

// Custom text field
class TextFieldComponent extends StatelessWidget {
  // text field variables
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const TextFieldComponent({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

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
              border: const GradientOutlineInputBorder(
                  gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
                  width: 2,),
              contentPadding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
            ),
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        )
        );
        
  }
}