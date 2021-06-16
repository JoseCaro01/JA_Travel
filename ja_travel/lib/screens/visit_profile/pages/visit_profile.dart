import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ja_travel/common_widgets/custom_elevatedbutton.dart';
import 'package:ja_travel/common_widgets/custom_image_base.dart';
import 'package:ja_travel/common_widgets/profile_photo_background.dart';
import 'package:ja_travel/models/post.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:ja_travel/common_widgets/profile_header.dart';
import 'package:provider/provider.dart';

class VisitProfile extends StatefulWidget {
  VisitProfile({Key? key, required this.data}) : super(key: key);

  final Object data;
  @override
  _VisitProfileState createState() => _VisitProfileState();
}

class _VisitProfileState extends State<VisitProfile> {
  List<PostModel>? posts;

  @override
  void initState() {
    posts = widget.data as List<PostModel>;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Perfil",
        style: Theme.of(context).appBarTheme.titleTextStyle,
      )),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Center(
                child: ProfileHeader(
                  postUpload: posts!.length.toString(),
                  description:
                      context.read<UserProvider>().visitUser!.description,
                  followed: context
                      .read<UserProvider>()
                      .visitUser!
                      .followed
                      .length
                      .toString(),
                  followers: context
                      .read<UserProvider>()
                      .visitUser!
                      .followers
                      .toString(),
                  username: context.read<UserProvider>().visitUser!.username,
                  bannerProfileImage:
                      context.read<UserProvider>().visitUser!.banner,
                  photoProfileImage:
                      context.read<UserProvider>().visitUser!.image,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50, left: 50, right: 50),
                child: CustomElevatedButton(
                    title: context.watch<UserProvider>().isFollowed()
                        ? "Dejar de seguir"
                        : "Seguir",
                    iconData: context.watch<UserProvider>().isFollowed()
                        ? Icons.remove
                        : FontAwesomeIcons.check,
                    onPressed: () =>
                        context.read<UserProvider>().toggleFollow()),
              ),
            ]),
          ),
          SliverGrid.count(
            crossAxisCount: 4,
            children: [
              ...posts!.map((e) => GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/detail_post',
                        arguments: [
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
            ],
          )
        ],
      ),
    );
  }
}
