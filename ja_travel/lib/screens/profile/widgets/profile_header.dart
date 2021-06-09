import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ja_travel/common_widgets/custom_elevatedbutton.dart';
import 'package:ja_travel/common_widgets/custom_image_base.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:ja_travel/provider/user_provider.dart';

import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              shape: BoxShape.circle),
          child: ClipOval(
            child: CustomImageBase(
                width: 200,
                height: 200,
                fit: BoxFit.cover,
                defaultImage: context.read<UserProvider>().user!.image),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 25),
          child: Text(
            context.watch<UserProvider>().user!.username,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "Seguidores",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    "${context.watch<UserProvider>().user!.followers.toString()} seguidores")
              ],
            ),
            Column(
              children: [
                Text(
                  "Posts subidos",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                    "${context.watch<PostProvider>().specificPosts(uid: FirebaseAuth.instance.currentUser!.uid).length} posts")
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        CustomElevatedButton(
          title: "Mis favoritos",
          onPressed: () => Navigator.pushNamed(context, '/my_favourite',
              arguments: context.read<UserProvider>().user!.favourites),
          iconData: Icons.card_travel,
        ),
        CustomElevatedButton(
          title: "Editar perfil",
          onPressed: () => Navigator.pushNamed(context, '/profile_edit'),
          iconData: Icons.settings,
        ),
        CustomElevatedButton(
          title: "Logout",
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.popAndPushNamed(context, '/login');
          },
          iconData: Icons.logout,
        ),
      ]),
    );
  }
}
