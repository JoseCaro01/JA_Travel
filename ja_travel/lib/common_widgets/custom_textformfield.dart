import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {required this.label,
      required this.validator,
      this.prefixIcon,
      this.suffixIcon,
      this.textInputAction = TextInputAction.next,
      this.maxLines = 1,
      this.enabled = true,
      required this.controller,
      this.obscureText = false});

  final String label;
  final String? Function(String? value) validator;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction textInputAction;
  final bool obscureText;
  final int maxLines;
  final bool enabled;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        textInputAction: textInputAction,
        obscureText: obscureText,
        maxLines: maxLines,
        enabled: enabled,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
