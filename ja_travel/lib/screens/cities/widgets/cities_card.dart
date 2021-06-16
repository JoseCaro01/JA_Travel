import 'package:flutter/material.dart';
import 'package:ja_travel/provider/cities_provider.dart';
import 'package:provider/provider.dart';

class CityCard extends StatelessWidget {
  const CityCard(
      {Key? key,
      required this.controller,
      required this.cities,
      required this.index})
      : super(key: key);

  /*Controlador encargado de mostrar las ciudades filtradas */
  final TextEditingController controller;
  /*Lista de ciudades filtradas */
  final List cities;
  /*Index para mostrar todas las ciudades en caso de no haber filtrado */
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.pushNamed(context, '/detailview_cities',
            arguments: controller.text.isEmpty
                ? context.read<CityProvider>().places[index]
                : cities[index]);
      },
      child: Container(
        child: Card(
          elevation: 8,
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Image.network(
                    controller.text.isEmpty
                        ? context.read<CityProvider>().places[index].imagen
                        : cities[index].imagen,
                    fit: BoxFit.cover,
                  )),
              ListTile(
                title: Text(controller.text.isEmpty
                    ? context.read<CityProvider>().places[index].nombre
                    : cities[index].nombre),
                subtitle: Text(controller.text.isEmpty
                    ? "${context.read<CityProvider>().places[index].nombre}, ${context.read<CityProvider>().places[index].provincia} (${context.read<CityProvider>().places[index].pais})"
                    : "${cities[index].nombre}, ${cities[index].provincia} (${cities[index].pais})"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
