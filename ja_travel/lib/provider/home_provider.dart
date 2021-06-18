import 'package:flutter/foundation.dart';

class HomeProvider with ChangeNotifier {
  /*Instanciacion del index controlador de la navegacion del home */
  int _currentIndex = 0;

  /*Metodo para obtener el currentIndex en la UI */
  int get currentIndex => _currentIndex;

  /*Metodo para cambiar indice */
  void changeIndex({required newIndex}) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
