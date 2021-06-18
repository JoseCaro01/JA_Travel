import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  /*Boolean para controlar modo oscuro/claro */
  bool mode = false;

  /*Instanciacion de SharedPreferences */
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  /*Constructor para inicializar el mode */
  SettingsProvider({required this.mode});

  /*Metodo para cambiar de modo oscuro a claro */
  Future<void> changeMode({required bool value}) async {
    await _prefs.then((prefs) => prefs.setBool('mode', value));
    mode = value;
    notifyListeners();
  }
}
