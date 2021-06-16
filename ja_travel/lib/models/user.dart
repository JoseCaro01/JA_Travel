import 'package:ja_travel/default_image.dart';
import 'package:ja_travel/default_image_banner.dart';

class UserModel {
  String username;
  String name;
  String address;
  String phone;
  String image;
  String? uid;
  String banner;
  String description;
  Map<String, dynamic> followed;
  int followers;
  Map<String, dynamic> favourites;

  UserModel(
      {required this.username,
      required this.name,
      required this.banner,
      required this.description,
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
        'description': description,
        'phone': phone,
        'image': image == "" ? DEFAULT_IMAGE_PROFILE : image,
        'banner': banner == "" ? DEFAULT_IMAGE_BANNER_PROFILE : banner,
        'uid': uid,
        'followed': followed,
        'followers': followers,
        'favourites': favourites
      };

  UserModel.fromJson(Map<String, dynamic> data)
      : username = data['username'],
        name = data['name'],
        description = data['description'],
        address = data['address'],
        phone = data['phone'],
        image = data['image'],
        followed = data['followed'],
        followers = data['followers'],
        favourites = data['favourites'],
        banner = data['banner'],
        uid = data['uid'];
}
