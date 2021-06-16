import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  /*Custom TextFormField con los estilos predefinidos de la app  */
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

  /*Titulo del TextFormField */
  final String label;
  /*Funcion para validar */
  final String? Function(String? value) validator;
  /*Icono delantero */
  final Icon? prefixIcon;
  /*Icono trasero */
  final Widget? suffixIcon;
  /*Accion del input */
  final TextInputAction textInputAction;
  /*Controladro de texto oscuro */
  final bool obscureText;
  /*Lineas maximas del input */
  final int maxLines;
  /*Controlador de enabled del input */
  final bool enabled;
  /*Controlador del input */
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
        ),
        validator: validator,
      ),
    );
  }
}
