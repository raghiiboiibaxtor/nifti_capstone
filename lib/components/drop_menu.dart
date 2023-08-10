import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class DropdownMenuComponent extends StatelessWidget {
  final dynamic value;
  final double width;
  final List<String> itemsList;
  final Widget hintText;
  final Function(dynamic value) onChanged;

  const DropdownMenuComponent(
      {super.key,
      required this.value,
      required this.width,
      required this.itemsList,
      required this.hintText,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      width: width,
      child: DropdownButtonFormField<String>(
          menuMaxHeight: 200,
          borderRadius: BorderRadius.circular(20),
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            border: GradientOutlineInputBorder(
              gradient: const LinearGradient(colors: [
                Color.fromRGBO(209, 147, 246, 1),
                Color.fromRGBO(115, 142, 247, 1),
                Color.fromRGBO(116, 215, 247, 1)
              ]),
              width: 2,
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          icon: const Icon(Icons.arrow_drop_down),
          hint: hintText,
          items: itemsList
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: (value) => onChanged(value)),
    );
  }
}
