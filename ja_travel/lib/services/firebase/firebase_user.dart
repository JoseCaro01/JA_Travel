import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ja_travel/models/post.dart';
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

  Future<void> logout() => FirebaseAuth.instance.signOut();

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

  /*Metodo para recuperar la contraseña */
  Future<void> recoverPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    print("Call recoverPassword good");
  }

  Future<void> savePostToFavourite(
      {required UserModel user, required PostModel post}) async {
    await FirebaseFirestore.instance
        .collection('perfil')
        .doc(user.uid)
        .get()
        .then((value) {
      Map<String, dynamic> posts = value['favourites'];
      posts["${post.uid}${post.id}"] = post.toMap();
      user.favourites = posts;
      FirebaseFirestore.instance
          .collection('perfil')
          .doc(user.uid)
          .set(user.toMap());
    });
    print("Call unsavePost successfull");
  }

  Future<void> unsavePostToFavourite(
      {required UserModel user, required PostModel post}) async {
    await FirebaseFirestore.instance
        .collection('perfil')
        .doc(user.uid)
        .get()
        .then((value) {
      Map<String, dynamic> posts = value['favourites'];
      posts.remove("${post.uid}${post.id}");
      user.favourites = posts;
      FirebaseFirestore.instance
          .collection('perfil')
          .doc(user.uid)
          .set(user.toMap());
    });
    print("Call unsavePost successfull");
  }

  Future<void> changePassword({required String password}) async {
    await FirebaseAuth.instance.currentUser!.updatePassword(password);
    print("Call changePassword successfull");
  }
}
