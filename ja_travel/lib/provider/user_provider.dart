import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ja_travel/models/post.dart';
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
  Future<void> loginUser(
      {required String email, required String password}) async {
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

  /* */
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

  isSave({required PostModel post}) {
    Map? value = user!.favourites["${post.uid}${post.id}"];
    return value != null;
  }

  Future<void> changePassword(
          {required String newPassword, required String password}) async =>
      loginUser(
              email: FirebaseAuth.instance.currentUser!.email!,
              password: password)
          .then((value) =>
              _firebaseUserApi.changePassword(password: newPassword));

  Future<void> logout() => FirebaseUserApi.instance.logout();
}
