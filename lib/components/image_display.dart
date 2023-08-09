import 'package:flutter/material.dart';

class ImageDisplay extends StatefulWidget {
  final double width;
  final double height;
  final ImageProvider image;
  final Function()? onPressed;

  const ImageDisplay(
      {super.key,
      required this.width,
      required this.height,
      required this.onPressed,
      required this.image});

  @override
  State<ImageDisplay> createState() => _ImageDisplayState();
}

class _ImageDisplayState extends State<ImageDisplay> {
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
          ),)
      ],
    );
  }
}
