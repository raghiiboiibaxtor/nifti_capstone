import 'package:flutter/material.dart';

// ? ImageDisplay == widget to display images on the users profile

// * ---------------- * (STATEFUL WIDGET) CLASS ImageDisplay (STATEFUL WIDGET) * ---------------- *
class ImageDisplay extends StatefulWidget {
  // Component Variables
  final double width;
  final double height;
  final ImageProvider image;
  final Function()? onPressed;
  // Required variables to be passed
  const ImageDisplay(
      {super.key,
      required this.width,
      required this.height,
      required this.onPressed,
      required this.image});

  @override
  State<ImageDisplay> createState() => _ImageDisplayState();
}
// * ---------------- * END OF (STATE) CLASS ImageDisplay (STATE) * ---------------- *

// * ---------------- * (STATE) CLASS _ImageDisplayState (STATE) * ---------------- *
class _ImageDisplayState extends State<ImageDisplay> {
  // * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: widget.image,
            ),
          ),
          height: widget.height,
          width: widget.width,
        ),
      ],
    );
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATE) CLASS _ImageDisplayState (STATE) * ---------------- *