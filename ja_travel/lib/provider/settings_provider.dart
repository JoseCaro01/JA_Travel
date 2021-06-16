import 'package:flutter/cupertino.dart';

class SettingsProvider with ChangeNotifier {
  bool _mode = false;

  bool get mode => _mode;

  void changeMode({required bool value}) {
    _mode = value;
    notifyListeners();
  }
}
