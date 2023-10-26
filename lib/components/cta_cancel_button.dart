import 'package:flutter/material.dart';
import 'cta_button.dart';
import 'app_theme.dart';

// ? ButtonComponent == custom button widget

// * ---------------- * (STATELESS WIDGET) CLASS ButtonComponent (STATELESS WIDGET) * ---------------- *
class CTACancelButton extends StatelessWidget {
  // Component Variables
  final Function()? onTap;
  final String text;
  final FontWeight fontWeight;
  final Color fontColor;
  final EdgeInsetsGeometry padding;
  final double letterSpacing;


  // Required & optional variables to be passed
  const CTACancelButton({
    super.key,
    required this.onTap,
    this.text = 'Cancel',
    this.fontWeight = FontWeight.bold,
    this.fontColor = const Color.fromARGB(255, 255, 255, 255),
    this.padding = const EdgeInsets.all(10),
    this.letterSpacing = 1,
  });

  // * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Button border & drop shadow
        Container(
          height: 36,
          width: 87,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              // spreadRadius: 1.0,
              blurRadius: 2.0,
              offset: const Offset(9, 0.5),
            ),
          ], borderRadius: const BorderRadius.all(Radius.circular(30))),
        ),
        // Cancel Button
        CTAButton(
          onTap: onTap,
          text: text,
          fontSize: 13,
          width: 86,
          height: 35,
          fontWeight: FontWeight.w600,
          color: niftiWhite,
          fontColor: const Color.fromRGBO(255, 159, 180, 1),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        ),
      ],
    );
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATELESS WIDGET) CLASS ButtonComponent (STATELESS WIDGET) * ---------------- *
