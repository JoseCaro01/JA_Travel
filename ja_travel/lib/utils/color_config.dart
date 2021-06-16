import 'package:flutter/material.dart';

class ColorConfig {
  static Color tabsIndicatorAndBottomNavigationColor = Colors.white;
  /*Metodo para obtener el Tema blanco */

  static ThemeData getDarkTheme() {
    tabsIndicatorAndBottomNavigationColor = Colors.white;
    return ThemeData(
        colorScheme: ColorScheme.dark(),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.white, foregroundColor: Colors.black),
        appBarTheme:
            AppBarTheme(titleTextStyle: TextStyle(color: Colors.white)));
  }

  static ThemeData getLightTheme() {
    tabsIndicatorAndBottomNavigationColor = Colors.black;
    return ThemeData(
        colorScheme: ColorScheme.light(),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.white, foregroundColor: Colors.black),
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
            color: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black)));
  }
}
