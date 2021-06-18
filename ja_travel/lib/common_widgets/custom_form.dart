import 'package:flutter/material.dart';

import 'custom_elevatedbutton.dart';

class CustomForm extends StatefulWidget {
  /* Custom Formulario encargado de gestionar el solo la key y la validacion como el guardado 
  Padding Formulario: 16 Horizontal*/
  CustomForm(
      {Key? key,
      required this.children,
      required this.titleButton,
      required this.iconButton,
      required this.onPressedButton,
      this.fixedSizeButton = const Size(225, 40),
      this.widthText = 100});

  /*Lista de widgets */
  final List<Widget> children;
  /*Titulo del boton del formulario */
  final String titleButton;
  /* Icono de boton */
  final IconData iconButton;
  /*Accion del boton del formulario */
  final void Function(bool validate) onPressedButton;
  /*Size añadido para editar el tamaño del boton */
  final Size fixedSizeButton;
  /*Width añadido para cambiar el tamaño que puede ocupar el contenido */
  final double widthText;

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  late final _key;

  @override
  void initState() {
    _key = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _key,
        child: Column(
          children: [
            ...widget.children,
            CustomElevatedButton(
              title: widget.titleButton,
              iconData: widget.iconButton,
              fixedSize: widget.fixedSizeButton,
              widthText: widget.widthText,
              onPressed: () {
                _key.currentState!.save();
                widget.onPressedButton(_key.currentState!.validate());
              },
            )
          ],
        ),
      ),
    );
  }
}
