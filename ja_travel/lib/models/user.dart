import 'package:ja_travel/default_image.dart';

class UserModel {
  String username;
  String name;
  String address;
  String phone;
  String image;
  String? uid;
  Map<String, dynamic> followed;
  int followers;
  Map<String, dynamic> favourites;

  UserModel(
      {required this.username,
      required this.name,
      this.uid,
      required this.address,
      required this.phone,
      required this.image,
      required this.followed,
      required this.favourites,
      required this.followers});

  Map<String, dynamic> toMap() => {
        'username': username,
        'name': name,
        'address': address,
        'phone': phone,
        'image': image == "" ? DEFAULT_IMAGE : image,
        'uid': uid,
        'followed': followed,
        'followers': followers,
        'favourites': favourites
      };

  UserModel.fromJson(Map<String, dynamic> data)
      : username = data['username'],
        name = data['name'],
        address = data['address'],
        phone = data['phone'],
        image = data['image'],
        followed = data['followed'],
        followers = data['followers'],
        favourites = data['favourites'],
        uid = data['uid'];
}
