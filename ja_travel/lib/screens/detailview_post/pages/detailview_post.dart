import 'package:flutter/material.dart';
import 'package:ja_travel/common_widgets/custom_image_base.dart';
import 'package:ja_travel/common_widgets/post_action_row.dart';
import 'package:ja_travel/models/comment.dart';
import 'package:ja_travel/models/post.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:ja_travel/utils/color_config.dart';
import 'package:provider/provider.dart';

class DetailViewPost extends StatefulWidget {
  DetailViewPost({required this.data});

  List data;
  @override
  _DetailViewPostState createState() => _DetailViewPostState();
}

class _DetailViewPostState extends State<DetailViewPost> {
  int? postIndex;
  bool? isAll;
  final TextEditingController message = TextEditingController();
  final ScrollController scroll = ScrollController();

  @override
  void dispose() {
    message.dispose();
    scroll.dispose();
    super.dispose();
  }

  @override
  void initState() {
    postIndex = widget.data[0];
    isAll = widget.data[2];
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.data[1]) {
        scroll.jumpTo(MediaQuery.of(context).size.height / 2);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isAll!
              ? context.read<PostProvider>().posts![postIndex!].username
              : context
                  .read<PostProvider>()
                  .followedPosts![postIndex!]
                  .username,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        leadingWidth: 105,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              ClipOval(
                child: CustomImageBase(
                    defaultImage: isAll!
                        ? context
                            .read<PostProvider>()
                            .posts![postIndex!]
                            .imagenPerfil
                        : context
                            .read<PostProvider>()
                            .followedPosts![postIndex!]
                            .imagenPerfil),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.749,
            child: SingleChildScrollView(
              controller: scroll,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: CustomImageBase(
                        fit: BoxFit.cover,
                        defaultImage: isAll!
                            ? context
                                .read<PostProvider>()
                                .posts![postIndex!]
                                .imagen
                            : context
                                .read<PostProvider>()
                                .followedPosts![postIndex!]
                                .imagen),
                  ),
                  PostActionRow(
                    isAll: isAll!,
                    showAllText: true,
                    descriptionTextStyle: TextStyle(
                        color:
                            ColorConfig.tabsIndicatorAndBottomNavigationColor),
                    postIndex: postIndex!,
                    commentsAction: () =>
                        scroll.jumpTo(MediaQuery.of(context).size.height / 2),
                  ),
                  ..._getComments(context),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: message,
                  decoration: InputDecoration(
                    labelText: "Mensaje",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                )),
                SizedBox(
                  width: 16,
                ),
                IconButton(
                    onPressed: () async {
                      if (message.text.isNotEmpty) {
                        await context
                            .read<PostProvider>()
                            .createComment(
                                comment: CommentModel(
                                    id: isAll!
                                        ? context
                                                .read<PostProvider>()
                                                .posts![postIndex!]
                                                .comments
                                                .length +
                                            1
                                        : context
                                                .read<PostProvider>()
                                                .followedPosts![postIndex!]
                                                .comments
                                                .length +
                                            1,
                                    uid:
                                        context.read<UserProvider>().user!.uid!,
                                    username: context
                                        .read<UserProvider>()
                                        .user!
                                        .username,
                                    imageProfile: context
                                        .read<UserProvider>()
                                        .user!
                                        .image,
                                    comment: message.text),
                                post: context
                                    .read<PostProvider>()
                                    .posts![postIndex!])
                            .then((value) => message.clear());
                      }
                    },
                    icon: Icon(Icons.keyboard_arrow_right))
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getComments(BuildContext context) {
    List<Widget> comments = [];
    CommentModel comment;
    PostModel post = (isAll!
        ? context.watch<PostProvider>().posts![postIndex!]
        : context.watch<PostProvider>().followedPosts![postIndex!]);

    post.comments.forEach((key, value) {
      comment = CommentModel.fromMap(value);
      comments.addAll([
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: CustomImageBase(
                        width: 20,
                        height: 20,
                        defaultImage: comment.imageProfile),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    comment.username,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              context.read<UserProvider>().user!.uid == comment.uid
                  ? PopupMenuButton(
                      onSelected: (value) => context
                          .read<PostProvider>()
                          .deleteComment(
                              post: context
                                  .read<PostProvider>()
                                  .posts![postIndex!],
                              comment: comment),
                      itemBuilder: (context) => ['Eliminar']
                          .map((e) => PopupMenuItem(value: e, child: Text(e)))
                          .toList(),
                    )
                  : SizedBox(
                      height: 45,
                    )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(comment.comment),
        )
      ]);
    });

    return comments;
  }
}
