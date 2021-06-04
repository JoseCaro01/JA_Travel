import 'package:flutter/material.dart';

class ColorConfig {
  static ThemeData getWhiteTheme() {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.white, foregroundColor: Colors.black),
    );
  }
}
