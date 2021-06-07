import 'package:flutter/material.dart';
import 'package:ja_travel/common_widgets/custom_image_base.dart';
import 'package:ja_travel/common_widgets/post_action_row.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:provider/provider.dart';

class PostBody extends StatelessWidget {
  const PostBody({Key? key, required this.postIndex}) : super(key: key);

  final int postIndex;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/detail_post',
          arguments: [postIndex, false]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: CustomImageBase(
              defaultImage:
                  context.watch<PostProvider>().posts![postIndex].imagen,
              fit: BoxFit.cover,
            ),
          ),
          PostActionRow(
              showAllText: false,
              descriptionTextStyle: TextStyle(color: Colors.black54),
              postIndex: postIndex)
        ],
      ),
    );
  }
}
