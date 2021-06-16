import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ja_travel/provider/home_provider.dart';
import 'package:ja_travel/screens/cities/pages/cities_widget.dart';
import 'package:ja_travel/screens/posts/pages/posts.dart';
import 'package:ja_travel/screens/profile/pages/profile_widget.dart';
import 'package:ja_travel/utils/color_config.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> screens = [];

  @override
  void initState() {
    screens = [PostWidget(), CitiesWidget(), ProfileWidget()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          selectedItemColor: ColorConfig.tabsIndicatorAndBottomNavigationColor,
          onTap: (value) {
            context.read<HomeProvider>().changeIndex(newIndex: value);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.post_add), label: "Posts"),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.city), label: "Ciudades"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil")
          ],
          currentIndex: context.watch<HomeProvider>().currentIndex,
        ),
        body: SafeArea(
            child: screens[context.read<HomeProvider>().currentIndex]));
  }
}
