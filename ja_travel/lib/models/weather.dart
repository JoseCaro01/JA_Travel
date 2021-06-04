class WeatherModel {
  var windSpeed,
      windDeg,
      temperature,
      temperatureMax,
      temperatureMin,
      humidity,
      icon,
      city,
      description,
      pressure;
  Map coord;

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
      : temperature = data['main']['temp'],
        windSpeed = data['wind']['speed'],
        windDeg = data['wind']['deg'],
        humidity = data['main']['humidity'],
        icon = data['weather'][0]['icon'],
        description = data['weather'][0]['description'],
        coord = data['coord'],
        temperatureMax = data['main']['temp_max'],
        temperatureMin = data['main']['temp_min'],
        pressure = data['main']['pressure'];
}
