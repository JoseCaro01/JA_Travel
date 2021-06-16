class WeatherModel {
  final String description;
  final String icon;
  final int windSpeed;
  final int windDeg;
  final int temperature;
  final int temperatureMax;
  final int temperatureMin;
  final int humidity;
  final int pressure;
  final Map coord;

  WeatherModel(
      {required this.temperature,
      required this.temperatureMax,
      required this.temperatureMin,
      required this.pressure,
      required this.windSpeed,
      required this.humidity,
      required this.icon,
      required this.description,
      required this.coord,
      required this.windDeg});

  WeatherModel.fromJson({required Map data})
      : temperature = data['main']['temp'].round(),
        windSpeed = data['wind']['speed'].round(),
        windDeg = data['wind']['deg'].round(),
        humidity = data['main']['humidity'].round(),
        icon = data['weather'][0]['icon'],
        description = data['weather'][0]['description'],
        coord = data['coord'],
        temperatureMax = data['main']['temp_max'].round(),
        temperatureMin = data['main']['temp_min'].round(),
        pressure = data['main']['pressure'].round();
}
