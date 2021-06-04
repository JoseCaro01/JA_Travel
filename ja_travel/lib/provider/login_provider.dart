import 'package:flutter/foundation.dart';

class LoginProvider with ChangeNotifier {
  /*Instanciacion del booleano encargado de controlar si mostrar o no la contraseña*/
  bool _showPassword = true;
  /*Metodo para obtener _showPassword en la UI */
  bool get showPassword => _showPassword;

  /*Metodo para cambiar el valor de _showPassword y actualizar la UI */
  void toogleShowPassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }
}
