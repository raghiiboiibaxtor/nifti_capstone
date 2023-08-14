import 'package:flutter/material.dart';

// ? TextDisplay == Custom text widget

// * ---------------- * (STATELESS WIDGET) CLASS TextDisplay (STATELESS WIDGET) * ---------------- *
class TextDisplay extends StatelessWidget {
  // Component Variables
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  // Required variables to be passed
  const TextDisplay(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      required this.color});

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
          ),
        )
      ],
    );
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATELESS WIDGET) CLASS TextDisplay (STATELESS WIDGET) * ---------------- *
