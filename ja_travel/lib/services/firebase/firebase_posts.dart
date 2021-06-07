import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ja_travel/models/post.dart';

class FirebasePostApi {
  FirebasePostApi._privateConstructor();
  static final FirebasePostApi _instance =
      FirebasePostApi._privateConstructor();
  static FirebasePostApi get instance => _instance;

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

  Future<void> createOrSetPost({required PostModel post}) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc("${post.id}${post.uid}")
        .set(post.toMap());

    print("Call createOrUpdate post successfull");
  }

  deletePost({required PostModel post}) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc("${post.id}${post.uid}")
        .delete();
    print("Call deletePost successfull");
  }

  setPostsImageProfile(
      {required List<PostModel> postList,
      required String imagenPerfil,
      required String uid}) {
    postList.forEach((post) async {
      if (uid == post.uid) {
        post.imagenPerfil = imagenPerfil;
      }
      post.comments.forEach((key, value) {
        if (key == uid) {
          value[1] = imagenPerfil;
        }
      });
      await FirebaseFirestore.instance
          .collection('posts')
          .doc("${post.id}${post.uid}")
          .set(post.toMap());
    });

    print("Call setPostImage successfull");
  }
}
