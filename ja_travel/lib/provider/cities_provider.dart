import 'package:flutter/cupertino.dart';
import 'package:ja_travel/models/place.dart';
import 'package:ja_travel/services/firebase/firebase_cities.dart';

class CityProvider with ChangeNotifier {
  /*Instanciacion de la lista donde se guardaran las ciudades*/
  List<Place> _places = [];
  /*Instanciacion del repositorio FirebaseCitiesApi */
  FirebaseCitiesApi _firebaseCitiesApi = FirebaseCitiesApi.instance;

  /*Metodo para pedir la cuidades en la UI */
  List<Place> get places => _places;

  /*Metodo para obtener las ciudades por primera vez  */
  getCities() async {
    _places = await _firebaseCitiesApi.getCities();
    notifyListeners();
  }
}
