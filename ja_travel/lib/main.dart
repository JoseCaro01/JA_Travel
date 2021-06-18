import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ja_travel/provider/cities_provider.dart';
import 'package:ja_travel/provider/login_provider.dart';
import 'package:ja_travel/provider/post_provider.dart';
import 'package:ja_travel/provider/settings_provider.dart';
import 'package:ja_travel/provider/user_provider.dart';
import 'package:ja_travel/provider/weather_provider.dart';
import 'package:ja_travel/route_generator.dart';
import 'package:ja_travel/provider/home_provider.dart';
import 'package:ja_travel/screens/login/pages/login_page.dart';
import 'package:ja_travel/utils/color_config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bool initialMode = await getInitialValue();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => LoginProvider()),
      ChangeNotifierProvider(create: (_) => CityProvider()),
      ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ChangeNotifierProvider(create: (_) => PostProvider()),
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(create: (_) => SettingsProvider(mode: initialMode))
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
        theme: context.watch<SettingsProvider>().mode
            ? ColorConfig.getDarkTheme()
            : ColorConfig.getLightTheme(),
        onGenerateRoute: RouteGenerator.generateRoute,
        home: LoginPage());
  }
}

Future<bool> getInitialValue() async {
  bool? initialMode;
  await SharedPreferences.getInstance()
      .then((value) => initialMode = value.getBool('mode'));
  return initialMode == null ? false : initialMode!;
}
