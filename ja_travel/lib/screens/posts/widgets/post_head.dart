import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ja_travel/common_widgets/custom_image_base.dart';
import 'package:ja_travel/common_widgets/loading.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:ja_travel/provider/home_provider.dart';
import 'package:provider/provider.dart';

class PostHead extends StatelessWidget {
  const PostHead({Key? key, required this.postIndex}) : super(key: key);

  final int postIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (context.read<PostProvider>().posts![postIndex].uid ==
            context.read<UserProvider>().user!.uid) {
          context.read<HomeProvider>().changeIndex(newIndex: 2);
        } else {
          showGeneralDialog(
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) => Loading(
              onCall: () async {
                await context.read<UserProvider>().getVisitUser(
                    uid: context.read<PostProvider>().posts![postIndex].uid);
                Navigator.pop(context);
                Navigator.pushNamed(context, '/visit_profile',
                    arguments: context.read<PostProvider>().specificPosts(
                        uid: context
                            .read<PostProvider>()
                            .posts![postIndex]
                            .uid));
              },
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipOval(
                  child: CustomImageBase(
                    width: 45,
                    height: 45,
                    defaultImage: context
                        .watch<PostProvider>()
                        .posts![postIndex]
                        .imagenPerfil,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  context.watch<PostProvider>().posts![postIndex].username,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )
              ],
            ),
            if (context.read<PostProvider>().posts![postIndex].uid ==
                FirebaseAuth.instance.currentUser!.uid)
              PopupMenuButton<String>(
                onSelected: (value) => choiceAction(context, value),
                itemBuilder: (BuildContext context) {
                  return ["Editar", "Eliminar"].map((String choice) {
                    return PopupMenuItem(
                      child: Text(choice),
                      value: choice,
                    );
                  }).toList();
                },
              )
          ],
        ),
      ),
    );
  }

  choiceAction(BuildContext context, String value) {
    if (value == "Editar") {
      /*showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) =>
            EditPost(post: context.read<PostProvider>().posts![postIndex]),
      );*/
    } else if (value == "Eliminar") {
      context
          .read<PostProvider>()
          .deletePost(post: context.read<PostProvider>().posts![postIndex]);
    }
  }
}
