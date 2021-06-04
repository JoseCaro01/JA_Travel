import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:ja_travel/models/comment.dart';
import 'package:ja_travel/models/post.dart';
import 'package:ja_travel/services/firebase/firebase_posts.dart';

class PostProvider with ChangeNotifier {
  /*Instanciacion de la lista donde se guardaran las ciudades*/
  List<PostModel>? _posts;

  /*Instanciacion del repositorio FirebaseCitiesApi */
  FirebasePostApi _firebasePostApi = FirebasePostApi.instance;

  /*Metodo para pedir la cuidades en la UI */
  List<PostModel>? get posts => _posts;

  /*Metodo para obtener tus propios post */
  List<PostModel> specificPosts({required String uid}) {
    List<PostModel> own = [];
    _posts!.forEach((element) {
      if (element.uid == uid) {
        own.add(element);
      }
    });
    return own;
  }

  /*Metodo para obtener las posts por primera vez  */
  Future<void> getPosts() async {
    _posts = await _firebasePostApi.getPosts();
    notifyListeners();
  }

  Future<void> createOrSetPost({required PostModel post}) async {
    await _firebasePostApi.createOrSetPost(post: post);
    await getPosts();
  }

  Future<void> toogleLike({required PostModel post}) async {
    if (!isLikeIt(post: post)) {
      post.likes[(FirebaseAuth.instance.currentUser!.uid)] = 0;
    } else {
      post.likes.remove(FirebaseAuth.instance.currentUser!.uid);
    }
    await _firebasePostApi.createOrSetPost(post: post);
    notifyListeners();
  }

  isLikeIt({required PostModel post}) {
    int? index = post.likes[FirebaseAuth.instance.currentUser!.uid];
    return index != null;
  }

  Future<void> deletePost({required PostModel post}) async {
    await _firebasePostApi.deletePost(post: post);
    await getPosts();
  }

  setPostsImageProfileImage(
      {required String imageProfile, required String uid}) async {
    await _firebasePostApi.setPostsImageProfile(
        postList: _posts!, imagenPerfil: imageProfile, uid: uid);
    await getPosts();
  }

  Future<void> createComment(
      {required PostModel post, required CommentModel comment}) async {
    post.comments.addAll(
        <String, dynamic>{"${comment.uid}${comment.id}": comment.toMap()});
    await createOrSetPost(post: post);
  }

  Future<void> deleteComment(
      {required PostModel post, required CommentModel comment}) async {
    print(comment.id);
    print(post.comments.remove("${comment.uid}${comment.id}"));
    await createOrSetPost(post: post);
  }
}
