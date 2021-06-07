import 'package:flutter/cupertino.dart';
import 'package:ja_travel/models/user.dart';
import 'package:ja_travel/services/firebase/firebase_user.dart';

class UserProvider extends ChangeNotifier {
  FirebaseUserApi _firebaseUserApi = FirebaseUserApi.instance;

  UserModel? user;
  UserModel? visitUser;

  /* Metodo Obtener los datos del usuario */
  getUserData() async {
    user = await _firebaseUserApi.getUserData();
    notifyListeners();
  }

  /*Metodo Actualizar los datos del usuario */
  updateUserData({required UserModel user}) async {
    await _firebaseUserApi.updateUserData(user: user);
    await getUserData();
  }

  /*Metodo Registrar usuario */
  Future<String?> registerUser(
      {required String email,
      required String password,
      required UserModel user}) async {
    try {
      await _firebaseUserApi
          .registerUser(email: email, password: password, user: user)
          .then((value) => getUserData());
    } catch (FirebaseAuthEmailAlreadyInUse) {
      return "Has introducido un email que se encuentra en uso";
    }
  }

  /* Metodo Loguear un usuario */
  loginUser({required String email, required String password}) async {
    await _firebaseUserApi.loginUser(email: email, password: password);
  }

  /*Metodo Visitar un usuario */
  getVisitUser({required String uid}) async {
    visitUser = await _firebaseUserApi.getUserData(uid: uid);
    notifyListeners();
  }

  /*Metodo para gestionar el follow  */
  toggleFollow() async {
    if (isFollowed()) {
      visitUser!.followers -= 1;
      user!.followed.remove(visitUser!.uid);
    } else {
      visitUser!.followers += 1;
      user!.followed[visitUser!.uid.toString()] = 0;
    }
    Future.wait([
      _firebaseUserApi.updateUserData(user: visitUser!),
      _firebaseUserApi.updateUserData(user: user!)
    ]);

    notifyListeners();
  }

  /*Metodo para ver si lo sigues o no */
  isFollowed() {
    int? value = user!.followed[visitUser!.uid];
    return value != null;
  }

  /*Meotodo para recuperar la contraseña */
  recoverPassword({required String email}) =>
      _firebaseUserApi.recoverPassword(email: email);
}
