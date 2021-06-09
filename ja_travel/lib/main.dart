import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ja_travel/provider/cities_provider.dart';
import 'package:ja_travel/provider/login_provider.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:ja_travel/provider/weather_provider.dart';
import 'package:ja_travel/screens/anonymus/pages/anonymus_page.dart';
import 'package:ja_travel/screens/create_post/pages/create_post.dart';
import 'package:ja_travel/screens/detailview_cities/pages/detail_view_cities.dart';
import 'package:ja_travel/screens/detailview_post/pages/detailview_post.dart';
import 'package:ja_travel/screens/detailview_profile/pages/profile_edit.dart';
import 'package:ja_travel/screens/edit_post/pages/edit_post.dart';
import 'package:ja_travel/screens/home/pages/home_page.dart';
import 'package:ja_travel/provider/home_provider.dart';
import 'package:ja_travel/screens/login/pages/login_page.dart';
import 'package:ja_travel/screens/my_favourite_post/pages/my_favourite_posts.dart';
import 'package:ja_travel/screens/register/pages/register_page.dart';
import 'package:ja_travel/utils/color_config.dart';
import 'package:provider/provider.dart';

/*TODO: Implementar Temas,cambiar contraseña */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => CityProvider()),
      ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ChangeNotifierProvider(create: (_) => PostProvider()),
      ChangeNotifierProvider(create: (_) => HomeProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JA Travel',
      theme: ColorConfig.getWhiteTheme(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/detail_post': (context) => DetailViewPost(),
        '/my_favourite': (context) => MyFavouritePosts(),
        '/profile_edit': (context) => ProfileEdit(),
        '/detailview_cities': (context) => DetailViewCities(),
        '/create_post': (context) => CreatePost(),
        '/edit_post': (context) => EditPost(),
        '/anonymus': (context) => AnonymusPage()
      },
      initialRoute: '/login',
    );
  }
}

class AnonymusScreen {}
