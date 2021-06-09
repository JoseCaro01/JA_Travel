import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ja_travel/models/post.dart';

class FirebasePostApi {
  /*Singleton para la API de Post */
  FirebasePostApi._privateConstructor();
  static final FirebasePostApi _instance =
      FirebasePostApi._privateConstructor();
  static FirebasePostApi get instance => _instance;

  /*Metodo para obtener todos los post */
  Future<List<PostModel>> getPosts() async {
    List<PostModel> posts = [];
    await FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((query) => query.docs.forEach((element) {
              posts.add(PostModel.fromMap(data: element.data()));
            }));

    return posts;
  }

  /*Metodo para crear o actualizar un post */
  Future<void> createOrSetPost({required PostModel post}) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc("${post.id}${post.uid}")
        .set(post.toMap());

    print("Call createOrUpdate post successfull");
  }

  /*Metodo para eliminar un post */
  deletePost({required PostModel post}) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc("${post.id}${post.uid}")
        .delete();
    print("Call deletePost successfull");
  }

  /*Metodo para settear la imagen de perfil de los usuarios y el nombre */
  setPostsImageAndUsernameProfile(
      {required List<PostModel> postList,
      required String imagenPerfil,
      required String username,
      required String uid}) {
    postList.forEach((post) async {
      if (uid == post.uid) {
        post.imagenPerfil = imagenPerfil;
        post.username = username;
      }
      post.comments.forEach((key, value) {
        if (key == uid) {
          value[1] = imagenPerfil;
          value[4] = username;
        }
      });
      await FirebaseFirestore.instance
          .collection('posts')
          .doc("${post.id}${post.uid}")
          .set(post.toMap());
    });

    print("Call setPostImageAndUsername successfull");
  }
}
