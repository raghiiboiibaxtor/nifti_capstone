import 'package:flutter/material.dart';

// ? ImageSelectionBox == widget to display placeholder image box & selection icon

// * ---------------- * (STATEFUL WIDGET) CLASS ImageSelectionBox (STATEFUL WIDGET) * ---------------- *
class ImageSelectionBox extends StatefulWidget {
  // Component Variables
  final double width;
  final double height;
  final Function()? onPressed;
  // Required variables to be passed
  const ImageSelectionBox(
      {super.key,
      required this.width,
      required this.height,
      required this.onPressed});

  @override
  State<ImageSelectionBox> createState() => _ImageSelectionBoxState();
}
// * ---------------- * END OF (STATE) CLASS ImaImageSelectionBoxgeDisplay (STATE) * ---------------- *

// * ---------------- * (STATE) CLASS _ImageSelectionBoxState (STATE) * ---------------- *
class _ImageSelectionBoxState extends State<ImageSelectionBox> {
  // * ---------------- * (BUILD WIDGET) * ---------------- *
  @override
  Widget build(BuildContext context) {
    return Container(
      // Placehold box
      decoration: BoxDecoration(
          color: const Color.fromARGB(51, 133, 157, 194),
          borderRadius: BorderRadius.circular(20)),
      height: widget.height,
      width: widget.width,
      // Selection icon
      child: IconButton(
        color: const Color.fromRGBO(115, 142, 247, 1),
        iconSize: 25,
        onPressed: widget.onPressed,
        icon: const Icon(Icons.add_a_photo_rounded),
      ),
    );
  }
  // * ---------------- * END OF (BUILD WIDGET) * ---------------- *
}
// * ---------------- * END OF (STATE) CLASS _ImageSelectionBoxState (STATE) * ---------------- *
