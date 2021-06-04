import 'package:flutter/cupertino.dart';
import 'package:ja_travel/models/user.dart';
import 'package:ja_travel/services/firebase/firebase_user.dart';

class UserProvider extends ChangeNotifier {
  FirebaseUserApi _firebaseUserApi = FirebaseUserApi.instance;

  UserModel? user;
  UserModel? visitUser;

  getUserData() async {
    user = await _firebaseUserApi.getUserData();
    notifyListeners();
  }

  updateUserData({required UserModel user}) async {
    await _firebaseUserApi.updateUserData(user: user);
    await getUserData();
  }

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

  loginUser({required String email, required String password}) async {
    await _firebaseUserApi.loginUser(email: email, password: password);
  }

  getVisitUser({required String uid}) async {
    visitUser = await _firebaseUserApi.getUserData(uid: uid);
    notifyListeners();
  }

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

  isFollowed() {
    int? value = user!.followed[visitUser!.uid];
    return value != null;
  }

  recoverPassword({required String email}) =>
      _firebaseUserApi.recoverPassword(email: email);
}
