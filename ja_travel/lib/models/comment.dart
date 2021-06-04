class CommentModel {
  final int id;
  final String uid;
  final String username;
  final String imageProfile;
  final String comment;

  CommentModel(
      {required this.id,
      required this.uid,
      required this.username,
      required this.imageProfile,
      required this.comment});

  CommentModel.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        uid = data['uid'],
        username = data['username'],
        imageProfile = data['imageProfile'],
        comment = data['comment'];

  Map<String, dynamic> toMap() => {
        'id': id,
        'uid': uid,
        'username': username,
        'imageProfile': imageProfile,
        'comment': comment
      };
}
