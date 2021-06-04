import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ja_travel/provider/cities_provider.dart';
import 'package:ja_travel/provider/login_provider.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:ja_travel/provider/weather_provider.dart';
import 'package:ja_travel/screens/login/pages/login_page.dart';
import 'package:ja_travel/screens/register/pages/register_page.dart';
import 'package:ja_travel/utils/color_config.dart';
import 'package:provider/provider.dart';

/*Validaciones realizadas :REGISTER LOGIN FORGETPASSWORD AND LOADING*/

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
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JA Travel',
      theme: ColorConfig.getWhiteTheme(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen()
      },
      home: LoginScreen(),
    );
  }
}
