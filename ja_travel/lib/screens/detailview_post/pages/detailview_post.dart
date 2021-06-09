import 'package:flutter/material.dart';
import 'package:ja_travel/common_widgets/custom_image_base.dart';
import 'package:ja_travel/common_widgets/post_action_row.dart';
import 'package:ja_travel/models/comment.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:provider/provider.dart';

class DetailViewPost extends StatefulWidget {
  @override
  _DetailViewPostState createState() => _DetailViewPostState();
}

class _DetailViewPostState extends State<DetailViewPost> {
  int? postIndex;
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
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if ((ModalRoute.of(context)!.settings.arguments as List)[1]) {
        scroll.jumpTo(MediaQuery.of(context).size.height / 2);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    postIndex = (ModalRoute.of(context)!.settings.arguments as List)[0];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.read<PostProvider>().posts![postIndex!].username,
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
                    defaultImage: context
                        .read<PostProvider>()
                        .posts![postIndex!]
                        .imagenPerfil),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            controller: scroll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  child: CustomImageBase(
                      fit: BoxFit.cover,
                      defaultImage: context
                          .read<PostProvider>()
                          .posts![postIndex!]
                          .imagen),
                ),
                PostActionRow(
                  showAllText: true,
                  descriptionTextStyle: TextStyle(color: Colors.black),
                  postIndex: postIndex!,
                  commentsAction: () =>
                      scroll.jumpTo(MediaQuery.of(context).size.height / 2),
                ),
                ...getComments(context),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              color: Colors.white,
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
                                      id: context
                                              .read<PostProvider>()
                                              .posts![postIndex!]
                                              .comments
                                              .length +
                                          1,
                                      uid: context
                                          .read<UserProvider>()
                                          .user!
                                          .uid!,
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
          ),
        ],
      ),
    );
  }

  List<Widget> getComments(BuildContext context) {
    List<Widget> comments = [];
    CommentModel comment;
    context
        .watch<PostProvider>()
        .posts![postIndex!]
        .comments
        .forEach((key, value) {
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
