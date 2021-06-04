import 'package:flutter/cupertino.dart';
import 'package:ja_travel/models/weather.dart';
import 'package:ja_travel/services/weather/weather_api.dart';

class WeatherProvider with ChangeNotifier {
  /*Instanciacion del objeto weather*/
  WeatherModel? _weather;
  /*Instanciacion del WeatherApi lugar de donde tomo los datos */
  WeatherApi _weatherApi = WeatherApi.instance;
  /*Delcaracion metodo para obtener el Weather almacenado*/
  WeatherModel? get weather => _weather;

  /*Metodo para obtener el tiempo de la API*/
  getWeatherCity({required String lat, required String lon}) async {
    if (_weather != null) {
      if (_weather!.coord['lon'] != lon && _weather!.coord['lat'] != lat) {
        _weather = await _weatherApi.getWeather(lat: lat, lon: lon);
      }
    } else {
      _weather = await _weatherApi.getWeather(lat: lat, lon: lon);
    }
    notifyListeners();
  }
}
