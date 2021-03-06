import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ja_travel/common_widgets/custom_image_base.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:ja_travel/common_widgets/profile_header.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late final List<Widget> images;

  @override
  void initState() {
    images = context
        .read<PostProvider>()
        .specificPosts(uid: context.read<UserProvider>().user!.uid!)
        .map((e) => GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, '/detail_post', arguments: [
                context
                    .read<PostProvider>()
                    .posts!
                    .indexWhere((element) => element.id == e.id),
                false,
                true
              ]),
              child: CustomImageBase(
                defaultImage: e.imagen,
                fit: BoxFit.cover,
              ),
            ))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: ListTile(
                      title: Text("Configuración"),
                      onTap: () => Navigator.pushNamed(context, '/settings'),
                      leading: Icon(Icons.settings),
                    ),
                  ),
                  ListTile(
                    title: Text("Editar perfil"),
                    onTap: () => Navigator.pushNamed(context, '/edit_profile'),
                    leading: Icon(Icons.edit),
                  ),
                  ListTile(
                    title: Text("Favoritos"),
                    onTap: () => Navigator.pushNamed(context, '/my_favourite'),
                    leading: Icon(Icons.star),
                  )
                ],
              ),
            ),
          )
        ],
        title: Text(
          "Perfil",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              ProfileHeader(
                postUpload: context
                    .watch<PostProvider>()
                    .specificPosts(uid: FirebaseAuth.instance.currentUser!.uid)
                    .length
                    .toString(),
                description: context.read<UserProvider>().user!.description,
                followed: context
                    .read<UserProvider>()
                    .user!
                    .followed
                    .length
                    .toString(),
                followers:
                    context.read<UserProvider>().user!.followers.toString(),
                username: context.read<UserProvider>().user!.username,
                photoProfileImage: context.read<UserProvider>().user!.image,
                bannerProfileImage: context.read<UserProvider>().user!.banner,
              ),
            ]),
          ),
          SliverGrid.count(
            crossAxisCount: 4,
            children: images,
          )
        ],
      ),
    );
  }
}
