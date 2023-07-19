import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const ButtonComponent({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(79, 219, 245, 1),
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
}