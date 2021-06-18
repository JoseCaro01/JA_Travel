import 'package:flutter/material.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:ja_travel/screens/posts/widgets/post_body.dart';
import 'package:ja_travel/screens/posts/widgets/post_head.dart';
import 'package:provider/provider.dart';

class PostAllOrFollowed extends StatefulWidget {
  const PostAllOrFollowed({Key? key, required this.isAll}) : super(key: key);

  final bool isAll;

  @override
  _PostAllOrFollowedState createState() => _PostAllOrFollowedState();
}

class _PostAllOrFollowedState extends State<PostAllOrFollowed> {
  @override
  void initState() {
    if (!widget.isAll)
      context.read<PostProvider>().specificPostsByListUID(
          uids: context.read<UserProvider>().user!.followed.keys.toList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<PostProvider>().getPosts(),
      child: ListView.builder(
          itemBuilder: (context, index) => Container(
                child: Card(
                  elevation: 8,
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      PostHead(
                        isAll: widget.isAll,
                        postIndex: index,
                      ),
                      PostBody(
                        isAll: widget.isAll,
                        postIndex: index,
                      ),
                    ],
                  ),
                ),
              ),
          itemCount: widget.isAll
              ? context.watch<PostProvider>().posts!.length
              : context.watch<PostProvider>().followedPosts!.length),
    );
  }
}
