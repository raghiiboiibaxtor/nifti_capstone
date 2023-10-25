import 'package:flutter/material.dart';
import 'cta_button.dart';

// ? ButtonComponent == custom button widget

// * ---------------- * (STATELESS WIDGET) CLASS ButtonComponent (STATELESS WIDGET) * ---------------- *
class CTAConfirmButton extends StatelessWidget {
  // Component Variables
  final Function()? onTap;
  final String text;
  final FontWeight fontWeight;
  final Color fontColor;
  final EdgeInsetsGeometry padding;
  final double letterSpacing;


  // Required & optional variables to be passed
  const CTAConfirmButton({
    super.key,
    required this.onTap,
    this.text = 'Confirm',
    this.fontWeight = FontWeight.bold,
    this.fontColor = const Color.fromARGB(255, 255, 255, 255),
    this.padding = const EdgeInsets.all(10),
    this.letterSpacing = 1,
  });

  // * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        // Button border & drop shadow
        Container(
          height: 45,
          width: 222,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(121, 212, 189, 1),
            boxShadow: [          
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              // spreadRadius: 1.0,
              blurRadius: 2.0,
              offset: const Offset(0, 1),
            ),
          ], borderRadius: const BorderRadius.all(Radius.circular(30))),
        ),
        // Confirm Button
        CTAButton(
          onTap: onTap,
          text: text,
          fontSize: 16,
          width: 218,
          height: 41,
          fontWeight: FontWeight.w900,
          color: const Color.fromRGBO(235, 254, 244, 1),
          fontColor: const Color.fromRGBO(121, 212, 189, 1),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          letterSpacing: 1,
        ),
      ],
    );
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATELESS WIDGET) CLASS ButtonComponent (STATELESS WIDGET) * ---------------- *
