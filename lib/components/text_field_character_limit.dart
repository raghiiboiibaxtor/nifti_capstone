import 'package:flutter/material.dart';
import 'package:nifti_locapp/components/app_theme.dart';

// ? TextFieldLimitComponent == custom text field widget with a character limit

// * ---------------- * (STATELESS WIDGET) CLASS TextFieldLimitComponent (STATELESS WIDGET) * ---------------- *
class TextFieldLimitComponent extends StatelessWidget {
  // ? Component variables
  final TextEditingController controller;
  final bool obscureText;
  final double width;
  final EdgeInsetsGeometry padding;
  final String labelText;
  final String? errorText;
  final Function(String)? validator;
  final bool hasError;
  final int maxLength;


  // ? Required variables to be passed
  const TextFieldLimitComponent({
    super.key,
    required this.controller,
    required this.obscureText,
    this.width = 350,
    required this.padding,
    this.labelText = 'Hint Text',
    this.errorText = '',
    this.validator,
    required this.hasError,
    required this.maxLength,
  });

  // * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: SizedBox(
          width: width,
          child: TextFormField(
            keyboardType: TextInputType.multiline,
             maxLines: 2,
            maxLength: maxLength,
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: const EdgeInsets.only(bottom: 0),
              labelText: labelText,
              labelStyle: TextStyle(
                  color: niftiGrey, fontSize: 17, fontWeight: FontWeight.w500),
              floatingLabelStyle: TextStyle(
                  color: niftiGrey, fontSize: 13, fontWeight: FontWeight.w500),
              // ? Standard border
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: niftiGrey,
                  width: 0.5,
                ),
              ),
              // ? Selected border style
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: niftiLightBlue,
                  width: 1.5,
                ),
              ),
              // ? Error borders & styles
              errorText: errorText,
              errorBorder: hasError
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(color: niftiPink, width: 1.5))
                  : UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: niftiGrey,
                        width: 0.5,
                      ),
                    ),
              focusedErrorBorder: hasError
                  ? UnderlineInputBorder(
                      borderSide: BorderSide(color: niftiPink, width: 1.5))
                  : UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: niftiLightBlue,
                        width: 1.5,
                      ),
                    ),
              errorStyle: TextStyle(
                color: niftiPink,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            // ? Input text style
            style: TextStyle(
              fontSize: 14,
              color: niftiGrey,
            ),
            
          ),
        ));
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATELESS WIDGET) CLASS TextFieldLimitComponent (STATELESS WIDGET) * ---------------- *