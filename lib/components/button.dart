import 'package:flutter/material.dart';

/* * ---------------- * (STATELESS WIDGET) CLASS ButtonComponent (STATELESS WIDGET) * ---------------- * */
class ButtonComponent extends StatelessWidget {
  // Component Variables
  final Function()? onTap;
  final String text;
  final Color color;

  // Required variables to be passed
  const ButtonComponent({super.key, required this.onTap, required this.text, required this.color});

  /* * ---------------- * (BUILD WIDGET) * ---------------- * */
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                        color: Color.fromRGBO(252, 250, 245, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                ))));
  }
  /* * ---------------- * END OF (BUILD WIDGET) * ---------------- * */
}
/* * ---------------- * END OF (STATELESS WIDGET) CLASS ButtonComponent (STATELESS WIDGET) * ---------------- * */
