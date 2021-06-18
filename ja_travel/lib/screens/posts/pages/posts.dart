import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ja_travel/screens/posts/widgets/post_all_or_followed.dart';
import 'package:ja_travel/utils/color_config.dart';

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
            children: [
              PostAllOrFollowed(
                isAll: true,
              ),
              PostAllOrFollowed(isAll: false)
            ],
          )),
    );
  }
}
