import 'package:flutter/material.dart';
import 'package:ja_travel/models/place.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:mapbox_gl/mapbox_gl.dart';

class MapPlaceWidget extends StatelessWidget {
  /*Widget para mostrar la ciudad en el Mapa */
  const MapPlaceWidget({
    Key? key,
    required this.place,
  }) : super(key: key);

  static const String ACCESS_TOKEN =
      "sk.eyJ1Ijoiam9zZWNhcm8wMSIsImEiOiJja29oaTk3NzUwcHU4Mm9wbHo3aDhxcW1rIn0.88U3yM3O1JOKtd6kbp2mhA";
  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapboxMap(
        accessToken: ACCESS_TOKEN,
        initialCameraPosition: CameraPosition(
            zoom: 14.0, target: LatLng(place.latitud, place.longitud)),
      ),
    );
  }
}
