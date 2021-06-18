import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:ja_travel/models/comment.dart';
import 'package:ja_travel/models/post.dart';
import 'package:ja_travel/services/firebase/firebase_posts.dart';

class PostProvider with ChangeNotifier {
  /*Instanciacion de la lista donde se guardaran los posts de todos*/
  List<PostModel>? _posts;

  List<PostModel>? _followedPosts;

  /*Instanciacion del repositorio FirebaseCitiesApi */
  FirebasePostApi _firebasePostApi = FirebasePostApi.instance;

  /*Metodo para pedir la cuidades en la UI */
  List<PostModel>? get posts => _posts;

  List<PostModel>? get followedPosts => _followedPosts;

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

  /*Obtener post mediante una serie de UID */
  void specificPostsByListUID({required List<String> uids}) {
    List<PostModel> posts = [];
    _posts!.forEach((post) {
      uids.forEach((uid) {
        if (post.uid == uid) {
          posts.add(post);
        }
      });
    });
    _followedPosts = posts;
  }

  /*Metodo para obtener las posts por primera vez  */
  Future<void> getPosts({List<String>? uids}) async {
    _posts = await _firebasePostApi.getPosts();
    if (uids != null) {
      specificPostsByListUID(uids: uids);
    }
    notifyListeners();
  }

  /*Metodo para crear o actualizar un post   */
  Future<void> createOrSetPost({required PostModel post}) async {
    await _firebasePostApi.createOrSetPost(post: post);
    await getPosts();
  }

  /*Metodo para dar o quitar like */
  Future<void> toogleLike({required PostModel post}) async {
    if (!isLikeIt(post: post)) {
      post.likes[(FirebaseAuth.instance.currentUser!.uid)] = 0;
    } else {
      post.likes.remove(FirebaseAuth.instance.currentUser!.uid);
    }
    await _firebasePostApi.createOrSetPost(post: post);
    notifyListeners();
  }

  /*Metodo para comprobar si ya tiene like */
  isLikeIt({required PostModel post}) {
    int? index = post.likes[FirebaseAuth.instance.currentUser!.uid];
    return index != null;
  }

  /*Metodo para borrar un post */
  Future<void> deletePost({required PostModel post}) async {
    await _firebasePostApi.deletePost(post: post);
    await getPosts();
  }

  /*Metodo para actualizar las imagenes de los post si cambia la imagen del perfil */
  setPostsImageProfileImage(
      {required String imageProfile,
      required String uid,
      required String username}) async {
    await _firebasePostApi.setPostsImageAndUsernameProfile(
        postList: _posts!,
        imagenPerfil: imageProfile,
        uid: uid,
        username: username);
    await getPosts();
  }

  /*Metodo para crear comentario */
  Future<void> createComment(
      {required PostModel post, required CommentModel comment}) async {
    post.comments.addAll(
        <String, dynamic>{"${comment.uid}${comment.id}": comment.toMap()});
    await createOrSetPost(post: post);
  }

  /*Metodo para eliminar comentario */
  Future<void> deleteComment(
      {required PostModel post, required CommentModel comment}) async {
    post.comments.remove("${comment.uid}${comment.id}").toString();
    await createOrSetPost(post: post);
  }
}
