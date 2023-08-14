import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

// ? CopyTool == custom widget allowing the user to copy text onTap

// * ---------------- * (STATELESS WIDGET) CLASS CopyTool (STATELESS WIDGET) * ---------------- *
class CopyTool extends StatelessWidget {
  // Component Variables
  final String text;
  final double fontSize;
  final double letterSpacing;
  // Required variables to be passed
  const CopyTool(
      {super.key,
      required this.text,
      required this.fontSize,
      this.letterSpacing = 0.8});

  // * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Tooltip(
          preferBelow: true,
          triggerMode: TooltipTriggerMode.tap,
          showDuration: const Duration(seconds: 3),
          message: "Copy",
          child: GradientText(
            text,
            style: TextStyle(
              letterSpacing: letterSpacing,
              fontSize: fontSize,
              fontWeight: FontWeight.w800,
            ),
            colors: const [
              Color.fromRGBO(209, 147, 246, 1),
              Color.fromRGBO(115, 142, 247, 1),
              Color.fromRGBO(116, 215, 247, 1)
            ],
          )),
      onTap: () {
        Clipboard.setData(ClipboardData(text: text));
      },
    );
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATELESS WIDGET) CLASS CopyTool (STATELESS WIDGET) * ---------------- *
