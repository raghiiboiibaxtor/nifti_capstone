import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CopyTool extends StatelessWidget {
  final String text;
  final double fontSize;
  const CopyTool({super.key, required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Tooltip(
        preferBelow: true,
        triggerMode: TooltipTriggerMode.tap,
        showDuration: const Duration(seconds: 3),
          message: "Copy", child: GradientText(text, 
          style: TextStyle(
            letterSpacing: .8,
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
          ),
          colors: const [Color.fromRGBO(209, 147, 246, 1),
          Color.fromRGBO(115, 142, 247, 1),
          Color.fromRGBO(116, 215, 247, 1)
          ],)),
      onTap: () {
        Clipboard.setData(ClipboardData(text: text));
      },
    );
  }
}