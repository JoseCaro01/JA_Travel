import 'package:flutter/material.dart';
import 'package:ja_travel/common_widgets/custom_image_base.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:ja_travel/screens/profile/widgets/profile_header.dart';
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
        .map((e) => CustomImageBase(
              defaultImage: e.imagen,
              fit: BoxFit.cover,
            ))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Perfil",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            ProfileHeader(),
            if (images.isNotEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Text(
                    "Posts",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              )
          ])),
          if (images.isNotEmpty)
            SliverGrid.count(
              crossAxisCount: 4,
              children: images,
            )
        ],
      ),
    );
  }
}
