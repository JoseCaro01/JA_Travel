import 'package:flutter/material.dart';
import 'package:ja_travel/models/place.dart';

class DescriptionPlaceWidget extends StatelessWidget {
  const DescriptionPlaceWidget({
    Key? key,
    required this.place,
  }) : super(key: key);

  /*Place pasado por argumento por DetailViewPlaces para mostrar la descripcion de un Place */
  final Place place;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: Image.network(
              place.imagen,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Text(
                    place.nombre,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.place,
                    size: 30,
                  ),
                  title: Text(
                    "${place.nombre}, ${place.provincia} (${place.pais})",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    place.descripcion,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
