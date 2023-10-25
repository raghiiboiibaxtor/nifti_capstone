import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nifti_locapp/components/app_theme.dart';
import 'package:nifti_locapp/components/text_display.dart';

// ? ButtonComponent == custom button widget

// * ---------------- * (STATELESS WIDGET) CLASS ButtonComponent (STATELESS WIDGET) * ---------------- *
class Button extends StatelessWidget {
  // Component Variables
  final Function()? onTap;
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final IconData icon;
  final Color iconColor;
  final double iconSize;

  // Required & optional variables to be passed
  const Button({
    super.key,
    required this.onTap,
    required this.text,
    this.color = const Color.fromRGBO(255, 255, 255, 1),
    this.fontSize = 13,
    this.fontWeight = FontWeight.w600,
    this.fontColor = const Color.fromRGBO(116, 142, 183, 1),
    this.icon = CupertinoIcons.add,
    this.iconColor = const Color.fromRGBO(116, 142, 183, 1),
    this.iconSize = 20,
  });

  // * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Base shape
          Container(
            height: 45,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1.0,
                  blurRadius: 3.0,
                  offset: const Offset(0, 1),
                ),
              ],
              color: niftiWhite,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(1),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),

          // Icon Shape
          Container(
            height: 45,
            width: 50,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 0.5,
                  blurRadius: 3.0,
                  offset: const Offset(0, 1),
                ),
              ],
              color: niftiWhite,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(1),
                bottomLeft: Radius.circular(17),
              ),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 70,
              ),
              TextDisplay(
                  text: text,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: fontColor),
            ],
          ),
        ],
      ),
    );
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATELESS WIDGET) CLASS ButtonComponent (STATELESS WIDGET) * ---------------- *


