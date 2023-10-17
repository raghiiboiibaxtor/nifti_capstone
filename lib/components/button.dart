import 'package:flutter/material.dart';

// ? ButtonComponent == custom button widget

// * ---------------- * (STATELESS WIDGET) CLASS ButtonComponent (STATELESS WIDGET) * ---------------- *
class ButtonComponent extends StatelessWidget {
  // Component Variables
  final Function()? onTap;
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final EdgeInsetsGeometry padding;

  // Required & optional variables to be passed
  const ButtonComponent({
    super.key,
    required this.onTap,
    required this.text,
    required this.color,
    this.fontSize = 18,
    this.fontWeight = FontWeight.bold,
    this.fontColor = const Color.fromARGB(255, 255, 255, 255),
    this.padding = const EdgeInsets.all(10),
  });

  // * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: GestureDetector(
            onTap: onTap,
            child: Container(
                padding: padding,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                        color: fontColor,
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        letterSpacing: 1),
                  ),
                ))));
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATELESS WIDGET) CLASS ButtonComponent (STATELESS WIDGET) * ---------------- *
