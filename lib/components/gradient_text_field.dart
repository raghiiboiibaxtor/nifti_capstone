import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:nifti_locapp/components/app_theme.dart';

// ? GradientTextFieldComponent == custom text field widget with a gradient border

// * ---------------- * (STATELESS WIDGET) CLASS GradientTextFieldComponent (STATELESS WIDGET) * ---------------- *
class GradientTextFieldComponent extends StatelessWidget {
  // ? Component variables
  final TextEditingController controller;
  final bool obscureText;
  final double width;
  final EdgeInsetsGeometry padding;
  final String labelText;
  final String? errorText;
  final Function(String)? validator;

  // ? Required variables to be passed
  const GradientTextFieldComponent({
    super.key,
    required this.controller,
    required this.obscureText,
    this.width = 350,
    required this.padding,
    this.labelText = 'Hint Text',
    this.errorText = '',
    this.validator,
  });

  // * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: Container(
          width: width,
          height: 45,
          decoration: BoxDecoration(
              color: niftiOffWhite, borderRadius: BorderRadius.circular(25)),
          child: TextFormField(
            validator: (value) {
              return null;
            },
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(
                color: niftiGrey,
                fontSize: 14,
              ),
              border: GradientOutlineInputBorder(
                gradient: niftiGradient,
                width: 1,
                borderRadius: BorderRadius.circular(25),
              ),
              floatingLabelStyle: TextStyle(
                  color: niftiGrey, fontSize: 14, fontWeight: FontWeight.w400),
              contentPadding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
            ),
            style: TextStyle(
              fontSize: 14,
              color: niftiGrey,
            ),
          ),
        ));
    /*return Padding(
        padding: padding,
        child: SizedBox(
          width: width,
          height: 60,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(bottom: -5),
              labelText: labelText,
              labelStyle: TextStyle(
                color: niftiGrey,
                fontWeight: FontWeight.w600,
                fontSize: 13,
                
              ),
              floatingLabelStyle: TextStyle(
                color: niftiGrey,
                fontSize: 13,
                fontWeight: FontWeight.w500
              ),
              //hintText: hintText,
              // ? Enabled Text Fields
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: niftiGrey,
                    width: 0.5,
                  ),
                ),
                // ? Selected Text Field
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: niftiLightBlue,
                    width: 1.5,
                  ),
                ),
              border: const UnderlineInputBorder(),
            ),
            style: TextStyle(
              fontSize: 14,
              color: niftiGrey,
            ),
          ),
        ));*/
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATELESS WIDGET) CLASS GradientTextFieldComponent (STATELESS WIDGET) * ---------------- *


/*
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:nifti_locapp/components/app_theme.dart';

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
    this.width = 350,
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
              color: niftiOffWhite,
              borderRadius: BorderRadius.circular(25)),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              border: GradientOutlineInputBorder(
                gradient: niftiGradient,
                width: 1,
                borderRadius: BorderRadius.circular(25),
              ),
              contentPadding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
            ),
            style: TextStyle(
              fontSize: 14,
              color: niftiGrey,
            ),
          ),
        ));
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATELESS WIDGET) CLASS GradientTextFieldComponent (STATELESS WIDGET) * ---------------- *


 */