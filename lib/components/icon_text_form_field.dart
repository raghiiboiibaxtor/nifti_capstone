import 'package:flutter/material.dart';
import 'package:nifti_locapp/components/app_theme.dart';

// ? GradientTextFieldComponent == custom text field widget

// * ---------------- * (STATELESS WIDGET) CLASS TextFieldComponent (STATELESS WIDGET) * ---------------- *
class IconTextFieldComponent extends StatelessWidget {
  // ? Component variables
  final TextEditingController controller;
  final bool obscureText;
  final double width;
  final EdgeInsetsGeometry padding;
  final String labelText;
  final String? errorText;
  final Function(String)? validator;
  final bool hasError;
  final Widget? child;

  // ? Required variables to be passed
  const IconTextFieldComponent({
    super.key,
    required this.controller,
    required this.obscureText,
    this.width = 350,
    required this.padding,
    this.labelText = 'Hint Text',
    this.errorText = '',
    this.validator,
    required this.hasError,
    required this.child,
  });

  // * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: SizedBox(
          width: width,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              
              prefixIcon: Container(
                margin:  const EdgeInsets.only(
                  right: 10,),
                  child: child,
              ) ,
              prefixIconColor: niftiGrey,
              prefixIconConstraints: const BoxConstraints(minWidth: 15, minHeight: 10),
              hintText: labelText,
              hintStyle: TextStyle(
                  color: niftiGrey, fontSize: 14, fontWeight: FontWeight.w500,),
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
// * ---------------- * END OF (STATELESS WIDGET) CLASS TextFieldComponent (STATELESS WIDGET) * ---------------- *