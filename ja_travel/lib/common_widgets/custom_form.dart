import 'package:flutter/material.dart';

import 'custom_elevatedbutton.dart';

class CustomForm extends StatelessWidget {
  CustomForm(
      {Key? key,
      required this.children,
      required this.titleButton,
      required this.iconButton,
      required this.onPressedButton});

  final List<Widget> children;
  final String titleButton;
  final IconData iconButton;
  final void Function(bool validate) onPressedButton;

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _key,
        child: Column(
          children: [
            ...children,
            CustomElevatedButton(
              title: titleButton,
              iconData: iconButton,
              onPressed: () {
                _key.currentState!.save();
                onPressedButton(_key.currentState!.validate());
              },
            )
          ],
        ),
      ),
    );
  }
}
