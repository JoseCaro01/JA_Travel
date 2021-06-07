import 'package:flutter/material.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:ja_travel/screens/posts/widgets/post_body.dart';
import 'package:ja_travel/screens/posts/widgets/post_head.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (context.watch<PostProvider>().posts == null) {
      context.read<PostProvider>().getPosts();
      return CircularProgressIndicator();
    } else {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Posts",
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => context.read<PostProvider>().getPosts(),
          child: ListView.builder(
            itemBuilder: (context, index) => Container(
              child: Card(
                elevation: 8,
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    PostHead(
                      postIndex: index,
                    ),
                    PostBody(postIndex: index),
                  ],
                ),
              ),
            ),
            itemCount: context.watch<PostProvider>().posts!.length,
          ),
        ),
      );
    }
  }
}
