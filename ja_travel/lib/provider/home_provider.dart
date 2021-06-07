import 'package:flutter/foundation.dart';


class HomeProvider with ChangeNotifier {
  /*Instanciacion del index controlador de la navegacion del home */
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex({required newIndex}) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
