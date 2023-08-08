import 'package:flutter/material.dart';

class ImageSelectionBox extends StatefulWidget {
  final double width;
  final double height;
  final Function()? onPressed;

  const ImageSelectionBox({super.key, required this.width, required this.height, required this.onPressed});

  @override
  State<ImageSelectionBox> createState() => _ImageSelectionBoxState();
}

class _ImageSelectionBoxState extends State<ImageSelectionBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(51, 133, 157, 194),
            borderRadius: BorderRadius.circular(20)),
        height: widget.height,
        width: widget.width,
        child: Positioned(
          child: IconButton(
            color: const Color.fromRGBO(115, 142, 247, 1),
            iconSize: 25,
            onPressed: widget.onPressed,
            icon: const Icon(Icons.add_a_photo_rounded),
          ),
        ));
  }
}
