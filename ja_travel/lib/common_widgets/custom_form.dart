import 'package:flutter/material.dart';

import 'custom_elevatedbutton.dart';

class CustomForm extends StatelessWidget {
  /* Custom Formulario encargado de gestionar el solo la key y la validacion como el guardado 
  Padding Formulario: 16 Horizontal*/
  CustomForm(
      {Key? key,
      required this.children,
      required this.titleButton,
      required this.iconButton,
      required this.onPressedButton});

  /*Lista de widgets */
  final List<Widget> children;
  /*Titulo del boton del formulario */
  final String titleButton;
  /* Icono de boton */
  final IconData iconButton;
  /*Accion del boton del formulario */
  final void Function(bool validate) onPressedButton;
  /*Key encargada de gestionar la valicacion del formulario */
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
