import 'package:flutter/material.dart';

abstract class MainTheme{

  static ThemeData build(){
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Colors.blue[800]!,
        onPrimary: Colors.amber,
        secondary: Colors.green,
        onSecondary: Colors.purple,
        error: Colors.red,
        onError: Colors.brown,
        surface: Colors.black,
        onSurface: Colors.pink,
        background: Colors.indigo[300]!,
        onBackground: Colors.cyan,
      ),
    );
  }
}