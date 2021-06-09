import 'package:flutter/material.dart';
import 'package:ja_travel/common_widgets/custom_appbar.dart';
import 'package:ja_travel/provider/cities_provider.dart';
import 'package:ja_travel/screens/cities/widgets/cities_card.dart';

import 'package:provider/provider.dart';

class CitiesWidget extends StatefulWidget {
  CitiesWidget({Key? key});
  @override
  _CitiesWidgetState createState() => _CitiesWidgetState();
}

class _CitiesWidgetState extends State<CitiesWidget> {
  /*Controlador encargado de controlar el texto del CustomTextFormField */
  late TextEditingController controller;
  /*Lista con las ciudades filtradas */
  List _cities = [];

  @override
  void initState() {
    /*Creancion del filtrado */
    context.read<CityProvider>().getCities();
    controller = TextEditingController();
    controller.addListener(() {
      setState(() {
        _cities = context
            .read<CityProvider>()
            .places
            .where((element) => element.nombre.startsWith(controller.text))
            .toList();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    /*Destruccion del controlador CustomTextFormField */
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        controller: controller,
        title: "Ciudades",
        titleSearch: 'Buscar ciudad',
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return CityCard(
            controller: controller,
            cities: _cities,
            index: index,
          );
        },
        itemCount: controller.text.isEmpty
            ? context.read<CityProvider>().places.length
            : _cities.length,
      ),
    );
  }
}
