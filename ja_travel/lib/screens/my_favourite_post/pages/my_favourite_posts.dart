import 'package:flutter/material.dart';
import 'package:ja_travel/common_widgets/custom_image_base.dart';
import 'package:ja_travel/models/post.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:provider/provider.dart';

class MyFavouritePosts extends StatefulWidget {
  MyFavouritePosts({Key? key}) : super(key: key);

  @override
  _MyFavouritePostsState createState() => _MyFavouritePostsState();
}

class _MyFavouritePostsState extends State<MyFavouritePosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mis favoritos",
              style: Theme.of(context).appBarTheme.titleTextStyle),
        ),
        body:
            GridView.count(crossAxisCount: 4, children: getComments(context)));
  }

  List<Widget> getComments(BuildContext context) {
    List<Widget> photos = [];
    PostModel post;
    context.watch<UserProvider>().user!.favourites.forEach((key, value) {
      post = PostModel.fromMap(data: value);
      photos.addAll([
        CustomImageBase(
          defaultImage: post.imagen,
          fit: BoxFit.cover,
        )
      ]);
    });

    return photos;
  }
}
