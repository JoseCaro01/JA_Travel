import 'package:flutter/material.dart';
import 'package:ja_travel/screens/anonymus/pages/anonymus_page.dart';
import 'package:ja_travel/screens/create_post/pages/create_post.dart';
import 'package:ja_travel/screens/detailview_cities/pages/detail_view_cities.dart';
import 'package:ja_travel/screens/detailview_post/pages/detailview_post.dart';
import 'package:ja_travel/screens/edit_password/pages/edit_password_profile.dart';
import 'package:ja_travel/screens/edit_post/pages/edit_post.dart';
import 'package:ja_travel/screens/edit_profile/pages/profile_edit.dart';
import 'package:ja_travel/screens/home/pages/home_page.dart';
import 'package:ja_travel/screens/login/pages/login_page.dart';
import 'package:ja_travel/screens/my_favourite_post/pages/my_favourite_posts.dart';
import 'package:ja_travel/screens/register/pages/register_page.dart';
import 'package:ja_travel/screens/settings/pages/settings_page.dart';
import 'package:ja_travel/screens/visit_profile/pages/visit_profile.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/detail_post':
        return MaterialPageRoute(
          builder: (_) => DetailViewPost(
            data: args as List,
          ),
        );
      case '/my_favourite':
        return MaterialPageRoute(
          builder: (_) => MyFavouritePosts(),
        );
      case '/edit_profile':
        return MaterialPageRoute(builder: (_) => ProfileEdit());
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case '/detailview_cities':
        return MaterialPageRoute(
          builder: (_) => DetailViewCities(
            data: args!,
          ),
        );
      case '/create_post':
        return MaterialPageRoute(
          builder: (_) => CreatePost(
            data: args!,
          ),
        );
      case '/edit_post':
        return MaterialPageRoute(
          builder: (_) => EditPost(
            data: args!,
          ),
        );
      case '/anonymus':
        return MaterialPageRoute(
          builder: (_) => AnonymusPage(),
        );
      case '/edit_password':
        return MaterialPageRoute(
          builder: (context) => EditPasswordProfile(),
        );
      case '/visit_profile':
        return MaterialPageRoute(
          builder: (context) => VisitProfile(
            data: args!,
          ),
        );
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
