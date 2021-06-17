import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  bool mode = false;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  SettingsProvider({required this.mode});

  Future<void> changeMode({required bool value}) async {
    await _prefs.then((prefs) => prefs.setBool('mode', value));
    mode = value;
    notifyListeners();
  }
}
