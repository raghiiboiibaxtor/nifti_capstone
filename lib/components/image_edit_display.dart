import 'package:flutter/material.dart';

// ? ImageEditDisplay == widget to display images while the user edit's their profile

// * ---------------- * (STATEFUL WIDGET) CLASS ImageEditDisplay (STATEFUL WIDGET) * ---------------- *
class ImageEditDisplay extends StatefulWidget {
  // Component Variables
  final double width;
  final double height;
  final ImageProvider image;
  final Function()? onPressed;
  // Required variables to be passed
  const ImageEditDisplay(
      {super.key,
      required this.width,
      required this.height,
      required this.onPressed,
      required this.image});

  @override
  State<ImageEditDisplay> createState() => _ImageEditDisplayState();
}
// * ---------------- * END OF (STATE) CLASS ImageDisplay (STATE) * ---------------- *

// * ---------------- * (STATE) CLASS _ImageEditDisplayState (STATE) * ---------------- *
class _ImageEditDisplayState extends State<ImageEditDisplay> {
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
        Positioned(
          right: 0,
          top: -5,
          child: IconButton(
            color: const Color.fromRGBO(252, 250, 245, 1),
            iconSize: 20,
            onPressed: widget.onPressed,
            icon: const Icon(Icons.add_a_photo_rounded),
          ),
        )
      ],
    );
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATE) CLASS _ImageEditDisplayState (STATE) * ---------------- *
