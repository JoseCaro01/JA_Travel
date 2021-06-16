import 'package:flutter/material.dart';
import 'package:ja_travel/common_widgets/custom_image_base.dart';
import 'package:ja_travel/common_widgets/post_action_row.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:provider/provider.dart';

class PostBody extends StatelessWidget {
  const PostBody({Key? key, required this.postIndex, required this.isAll})
      : super(key: key);

  final int postIndex;
  final bool isAll;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/detail_post',
          arguments: [postIndex, false, isAll]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 275,
            child: CustomImageBase(
              defaultImage: isAll
                  ? context.read<PostProvider>().posts![postIndex].imagen
                  : context
                      .read<PostProvider>()
                      .followedPosts![postIndex]
                      .imagen,
              fit: BoxFit.cover,
            ),
          ),
          PostActionRow(
              isAll: isAll,
              showAllText: false,
              descriptionTextStyle:
                  TextStyle(color: Theme.of(context).disabledColor),
              postIndex: postIndex)
        ],
      ),
    );
  }
}
