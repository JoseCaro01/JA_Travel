import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ja_travel/provider/home_provider.dart';
import 'package:ja_travel/screens/cities/pages/cities_widget.dart';
import 'package:ja_travel/screens/posts/pages/posts.dart';
import 'package:ja_travel/screens/profile/pages/profile_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
