import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({
    Key? key,
    required this.label,
    required this.icon,
    this.width = 200,
    this.textStyle,
  }) : super(key: key);

  final String label;
  final Icon icon;
  final double width;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: icon,
        ),
        Container(
          child: Text(
            label,
            style:
                textStyle != null ? textStyle! : TextStyle(color: Colors.black),
          ),
          width: width,
        ),
      ],
    );
  }
}
