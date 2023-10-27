import 'package:flutter/material.dart';

// ? TextDisplay == Custom text widget

// * ---------------- * (STATELESS WIDGET) CLASS TextDisplay (STATELESS WIDGET) * ---------------- *
class TextDisplay extends StatelessWidget {
  // ? Component Variables
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final double letterSpacing;
  final TextDecoration decoration;

  // ? Required variables to be passed
  const TextDisplay(
      {super.key,
      required this.text,
      this.fontSize = 12,
      this.fontWeight = FontWeight.normal,
      this.color = const Color.fromRGBO(116, 142, 183, 1),
      this.letterSpacing = 0,
      this.decoration = TextDecoration.none,
      });

  // * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            letterSpacing: letterSpacing,
          ),
        )
      ],
    );
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATELESS WIDGET) CLASS TextDisplay (STATELESS WIDGET) * ---------------- *
