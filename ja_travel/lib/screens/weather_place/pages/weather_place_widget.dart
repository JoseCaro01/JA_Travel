import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ja_travel/models/place.dart';
import 'package:ja_travel/provider/weather_provider.dart';
import 'package:ja_travel/screens/weather_place/widgets/custom_card_weather.dart';
import 'package:provider/provider.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherPlaceWidget extends StatefulWidget {
  const WeatherPlaceWidget({Key? key, required this.place}) : super(key: key);
  /*Place pasado por argumento para mostrar el tiempo dentro de un Place */
  final Place place;

  @override
  _WeatherPlaceWidgetState createState() => _WeatherPlaceWidgetState();
}

class _WeatherPlaceWidgetState extends State<WeatherPlaceWidget> {
  @override
  void initState() {
    context.read<WeatherProvider>().getWeatherCity(
        lat: widget.place.latitud.toString(),
        lon: widget.place.longitud.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<WeatherProvider>().weather == null) {
      return Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ));
    } else {
      return Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                  "http://openweathermap.org/img/wn/${context.read<WeatherProvider>().weather!.icon}@2x.png"),
              Text(
                "${context.read<WeatherProvider>().weather!.temperature.toString()}º",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              CustomCardWeather(
                label: "Temperatura máxima",
                labelTwo: "Temperatura mínima",
                data:
                    "${context.read<WeatherProvider>().weather!.temperatureMax.toString()}º",
                dataTwo:
                    "${context.read<WeatherProvider>().weather!.temperatureMin.toString()}º",
                icon: Icon(FontAwesomeIcons.thermometerFull),
                iconTwo: Icon(FontAwesomeIcons.thermometerEmpty),
              ),
              CustomCardWeather(
                  label: "Velocidad del viento",
                  labelTwo: "Dirección del viento",
                  data:
                      "${context.read<WeatherProvider>().weather!.windSpeed.toString()}m/s",
                  dataTwo:
                      "${context.read<WeatherProvider>().weather!.windDeg.toString()}º",
                  icon: Icon(FontAwesomeIcons.wind),
                  iconTwo: Icon(FontAwesomeIcons.directions)),
              CustomCardWeather(
                  label: "Humedad",
                  labelTwo: "Presión",
                  data:
                      "${context.read<WeatherProvider>().weather!.humidity.toString()}%",
                  dataTwo:
                      "${context.read<WeatherProvider>().weather!.pressure.toString()}mbar",
                  icon: Icon(WeatherIcons.humidity),
                  iconTwo: Icon(WeatherIcons.barometer)),
            ],
          ),
        ),
      );
    }
  }
}
