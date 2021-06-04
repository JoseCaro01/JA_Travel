import 'package:flutter/material.dart';
import 'package:ja_travel/common_widgets/custom_tile.dart';

class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton(
      {required this.title,
      required this.iconData,
      required this.onPressed,
      this.fixedSize = const Size(225, 40)});

  final String title;
  final VoidCallback onPressed;
  final IconData iconData;
  final Size fixedSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: fixedSize,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          primary: Colors.white,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTile(
              width: 100,
              label: title,
              icon: Icon(
                iconData,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
