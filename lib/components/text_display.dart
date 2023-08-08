import 'package:flutter/material.dart';

class TextDisplay extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  const TextDisplay({super.key, required this.text, required this.fontSize, required this.fontWeight, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        // Text
        Text(text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),)
      ],
    );
  }
}