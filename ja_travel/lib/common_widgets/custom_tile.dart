import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  /*Custom ListTile 
  Width: 200*/
  const CustomTile({
    Key? key,
    required this.label,
    required this.icon,
    this.width = 200,
    this.textStyle,
  }) : super(key: key);

  /*Titulo del customListTile */
  final String label;
  /*Icono del CustomListTile */
  final Icon icon;
  /* Anchura del CustomListTile */
  final double width;
  /*Estilo del titulo del CustomListTile */
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
            overflow: TextOverflow.ellipsis,
            style: textStyle,
          ),
          width: width,
        ),
      ],
    );
  }
}
