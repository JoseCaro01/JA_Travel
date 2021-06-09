class PostModel {
  String destino;
  String descripcion;
  final String uid;
  String imagenPerfil;
  String imagen;
  String username;
  String id;
  Map likes;
  Map comments;

  PostModel(
      {required this.destino,
      required this.descripcion,
      required this.uid,
      required this.imagen,
      required this.imagenPerfil,
      required this.username,
      required this.id,
      required this.comments,
      required this.likes});

  PostModel.fromMap({required Map data})
      : destino = data['destino'],
        descripcion = data['descripcion'],
        uid = data['uid'],
        imagen = data['imagen'],
        imagenPerfil = data['imagenPerfil'],
        id = data['id'],
        likes = data['likes'],
        comments = data['comments'],
        username = data['username'];

  Map<String, dynamic> toMap() => {
        'destino': destino,
        'descripcion': descripcion,
        'uid': uid,
        'imagen': imagen,
        'imagenPerfil': imagenPerfil,
        'username': username,
        'likes': likes,
        'comments': comments,
        'id': id
      };
}
