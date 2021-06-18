import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ja_travel/models/post.dart';
import 'package:ja_travel/models/user.dart';
import 'package:ja_travel/services/firebase/firebase_user.dart';

class UserProvider extends ChangeNotifier {
  UserModel? user;
  UserModel? visitUser;

  /* Metodo Obtener los datos del usuario */
  getUserData() async {
    user = await FirebaseUserApi.instance.getUserData();
    notifyListeners();
  }

  /*Metodo Actualizar los datos del usuario */
  updateUserData({required UserModel user}) async {
    await FirebaseUserApi.instance.updateUserData(user: user);
    await getUserData();
  }

  /*Metodo Registrar usuario */
  Future<String?> registerUser(
      {required String email,
      required String password,
      required UserModel user}) async {
    try {
      await FirebaseUserApi.instance
          .registerUser(email: email, password: password, user: user)
          .then((value) => getUserData());
    } catch (e) {
      return "Has introducido un email que se encuentra en uso";
    }
  }

  /* Metodo Loguear un usuario */
  Future<String?> loginUser(
      {required String email, required String password}) async {
    try {
      await FirebaseUserApi.instance
          .loginUser(email: email, password: password);
    } catch (e) {
      return "Has introducido una contraseña erronea";
    }
  }

  /*Metodo Visitar un usuario */
  getVisitUser({required String uid}) async {
    visitUser = await FirebaseUserApi.instance.getUserData(uid: uid);
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
      FirebaseUserApi.instance.updateUserData(user: visitUser!),
      FirebaseUserApi.instance.updateUserData(user: user!)
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
      FirebaseUserApi.instance.recoverPassword(email: email);

  /*Metodo toogle para guardar y quitar de favoritos una publicacion */
  toogleFavourite({required PostModel post}) async {
    if (isSave(post: post)) {
      await FirebaseUserApi.instance
          .unsavePostToFavourite(user: user!, post: post);
    } else {
      await FirebaseUserApi.instance
          .savePostToFavourite(user: user!, post: post);
    }
    await getUserData();
    notifyListeners();
  }

  /*Metodo para saber si esta guardado o no */
  isSave({required PostModel post}) {
    Map? value = user!.favourites["${post.uid}${post.id}"];
    return value != null;
  }

  /*Metodo para cambiar contraseña */
  Future<String?> changePassword(
      {required String newPassword, required String password}) async {
    try {
      await loginUser(
              email: FirebaseAuth.instance.currentUser!.email!,
              password: password)
          .then((value) =>
              FirebaseUserApi.instance.changePassword(password: newPassword));
    } catch (e) {
      return "Has introducido una contraseña erronea";
    }
  }

  /*Metodo para desloguearse */
  Future<void> logout() async {
    user = null;
    await FirebaseUserApi.instance.logout();
  }
}
