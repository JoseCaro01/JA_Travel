import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:ja_travel/screens/posts/widgets/post_body.dart';
import 'package:ja_travel/screens/posts/widgets/post_head.dart';
import 'package:ja_travel/utils/color_config.dart';
import 'package:provider/provider.dart';

class PostWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "Posts",
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            bottom: TabBar(
              indicatorColor: ColorConfig.tabsIndicatorAndBottomNavigationColor,
              labelColor: ColorConfig.tabsIndicatorAndBottomNavigationColor,
              tabs: [
                Tab(
                  icon: Icon(
                    FontAwesomeIcons.globe,
                  ),
                ),
                Tab(
                  icon: Icon(
                    FontAwesomeIcons.users,
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [AllPost(), FollowedPost()],
          )),
    );
  }
}

class AllPost extends StatelessWidget {
  const AllPost({Key? key}) : super(key: key);

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
                        isAll: true,
                        postIndex: index,
                      ),
                      PostBody(
                        isAll: true,
                        postIndex: index,
                      ),
                    ],
                  ),
                ),
              ),
          itemCount: context.watch<PostProvider>().posts!.length),
    );
  }
}

class FollowedPost extends StatefulWidget {
  const FollowedPost({Key? key}) : super(key: key);

  @override
  _FollowedPostState createState() => _FollowedPostState();
}

class _FollowedPostState extends State<FollowedPost> {
  @override
  void initState() {
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
                        isAll: false,
                        postIndex: index,
                      ),
                      PostBody(
                        isAll: false,
                        postIndex: index,
                      ),
                    ],
                  ),
                ),
              ),
          itemCount: context.watch<PostProvider>().followedPosts!.length),
    );
  }
}
