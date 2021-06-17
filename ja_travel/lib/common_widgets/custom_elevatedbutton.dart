import 'package:flutter/material.dart';
import 'package:ja_travel/common_widgets/custom_tile.dart';

class CustomElevatedButton extends StatelessWidget {
  /* Boton predeterminado para toda la app 
  Boton margin: 8 Vertical*/
  CustomElevatedButton(
      {required this.title,
      required this.iconData,
      required this.onPressed,
      this.widthText = 100,
      this.fixedSize = const Size(225, 40)});

  /*Titulo del boton */
  final String title;
  /*Accion que presenta el boton al ser pulsado */
  final VoidCallback onPressed;
  /*Tipo de icono que debe mostrar */
  final IconData iconData;
  /*Tamaño del boton (Default: 225,40) */
  final Size fixedSize;
  final double widthText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
              textStyle: TextStyle(color: Colors.black),
              width: widthText,
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
