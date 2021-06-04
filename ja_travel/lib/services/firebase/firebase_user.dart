import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ja_travel/models/user.dart';

class FirebaseUserApi {
  /*Singleton FirebaseUserApi */
  FirebaseUserApi._privateConstructor();
  static final FirebaseUserApi _instance =
      FirebaseUserApi._privateConstructor();
  static FirebaseUserApi get instance => _instance;

  /*Metodo para obtener los datos del usuario */
  Future<UserModel> getUserData({String? uid}) async {
    DocumentSnapshot userDocument = await FirebaseFirestore.instance
        .collection('perfil')
        .doc(uid == null ? FirebaseAuth.instance.currentUser!.uid : uid)
        .get();
    print("Call getUser good");
    return UserModel.fromJson(userDocument.data()!);
  }

  /*Metodo para actualizar los datos del usuario */
  Future<void> updateUserData({required UserModel user}) async {
    await FirebaseFirestore.instance
        .collection('perfil')
        .doc(user.uid)
        .update(user.toMap());
    print("Call updateUser good");
  }

  /*Metodo para loguear el usuario */
  Future<void> loginUser(
      {required String email, required String password}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print("Call loginUser good");
  }

  /*Metodo para registrar el usuario */
  Future<void> registerUser(
      {required String email,
      required String password,
      required UserModel user}) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    user.uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('perfil')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(user.toMap());
    print("Call registerUser good");
  }

  Future<void> recoverPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    print("Call recoverPassword good");
  }
}
