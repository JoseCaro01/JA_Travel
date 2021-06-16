import 'package:flutter/material.dart';
import 'package:ja_travel/common_widgets/profile_photo_background.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader(
      {Key? key,
      required this.username,
      required this.postUpload,
      required this.followers,
      required this.followed,
      required this.photoProfileImage,
      required this.bannerProfileImage,
      required this.description})
      : super(key: key);

  final String username;
  final String postUpload;
  final String followers;
  final String followed;
  final String description;
  final String photoProfileImage;
  final String bannerProfileImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfilePhotoBackground(
            photoProfileImage: photoProfileImage,
            bannerProfileImage: bannerProfileImage,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 25),
            child: Text(
              username,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Seguidores",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${followers.toString()} seguidores")
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Seguidos",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("${followed.toString()} seguidores")
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Posts subidos",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text("${postUpload.toString()} posts"),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                description,
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.start,
              ),
            ),
          )
        ],
      ),
    );
  }
}
