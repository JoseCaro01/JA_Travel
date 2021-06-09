import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ja_travel/models/weather.dart';

class WeatherApi {
  /*Creacion objecto singleton */
  WeatherApi._privateConstructor();
  static final WeatherApi _instance = WeatherApi._privateConstructor();
  static WeatherApi get instance => _instance;

  /*Metodo para obtener el tiempo en una latitud y longitud especifica */
  getWeather({required String lat, required String lon}) async {
    final String url =
        "http://api.openweathermap.org/data/2.5/weather?lat=${lat.toString()}&lon=${lon.toString()}&appid=8fbe1a99f2b9c4f864e786ffccae0e3e&units=metric";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      print("Call getWeather is successful");
      return WeatherModel.fromJson(data: data);
    }
  }
}
