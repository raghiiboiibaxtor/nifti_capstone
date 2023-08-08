import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyTool extends StatelessWidget {
  final String text;
  const CopyTool({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Tooltip(
        //waitDuration: const Duration(milliseconds: 1),
        preferBelow: true,
          message: "Copy", child: Text(text)),
      onTap: () {
        Clipboard.setData(ClipboardData(text: text));
      },
    );
  }
}