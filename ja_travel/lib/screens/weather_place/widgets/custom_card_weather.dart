import 'package:flutter/material.dart';
import 'package:ja_travel/common_widgets/custom_tile.dart';

class CustomCardWeather extends StatelessWidget {
  /*Custom Widget creado para mostrar dos caracteristicas del tiempo con un label e icono 
  Margin:10 vertical,8 horizontal*/
  CustomCardWeather(
      {required this.label,
      required this.labelTwo,
      required this.data,
      required this.dataTwo,
      required this.icon,
      required this.iconTwo});

  /*Texto de label 1 */
  final String label;
  /*Texto del label 2 */
  final String labelTwo;
  /*Resultado del label 1 */
  final String data;
  /*Resultado del label 2 */
  final String dataTwo;
  /*Icono del label 1 */
  final Icon icon;
  /*Icono del label 2 */
  final Icon iconTwo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTile(
                        icon: icon,
                        label: label,
                      ),
                      Text(data),
                    ]),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTile(
                        icon: iconTwo,
                        label: labelTwo,
                      ),
                      Text(dataTwo),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
