import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_borders/gradient_borders.dart';

// ? CharacterLimitFieldComponent == widget to limit & display character limits

// * ---------------- * (STATEFUL WIDGET) CLASS CharacterLimitFieldComponent (STATEFUL WIDGET) * ---------------- *
class CharacterLimitFieldComponent extends StatefulWidget {
  // Component Variables
  final TextEditingController controller;
  final String hintText;
  final double width;
  final EdgeInsetsGeometry padding;
  // Required variables to be passed
  const CharacterLimitFieldComponent({
    super.key,
    required this.controller,
    required this.hintText,
    required this.width,
    required this.padding,
  });

  @override
  State<CharacterLimitFieldComponent> createState() =>
      _CharacterLimitFieldComponentState();
}
// * ---------------- * END OF (STATEFUL WIDGET) CLASS CharacterLimitFieldComponent (STATE) * ---------------- *

// * ---------------- * (STATE) CLASS _RegisterPageState (STATE) * ---------------- *
class _CharacterLimitFieldComponentState
    extends State<CharacterLimitFieldComponent> {
  // Characters counting & mex setting variables
  var characterCounter = 75;
  var maxCharacters = 75;

  // * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: widget.padding,
        child: Container(
          width: widget.width,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(252, 250, 245, 1),
              borderRadius: BorderRadius.circular(25)),
          child: TextField(
            // ? subtracting remaining characters from max amount
            onChanged: (value) {
              setState(() {
                characterCounter = maxCharacters - value.length;
              });
            },
            maxLength: 75,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            controller: widget.controller,
            decoration: InputDecoration(
              counterStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
              // ? display characters remaining out of max amount
              counterText: " $characterCounter / $maxCharacters",
              hintText: widget.hintText,
              border: GradientOutlineInputBorder(
                gradient: const LinearGradient(colors: [
                  Color.fromRGBO(209, 147, 246, 1),
                  Color.fromRGBO(115, 142, 247, 1),
                  Color.fromRGBO(116, 215, 247, 1)
                ]),
                width: 2,
                borderRadius: BorderRadius.circular(25),
              ),
              contentPadding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
              ),
            ),
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ));
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATE) CLASS _CharacterLimitFieldComponentState (STATE) * ---------------- *
