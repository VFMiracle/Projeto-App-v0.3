import 'package:flutter/material.dart';

abstract class MainTheme{

  static ThemeData build(){
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Color.fromARGB(255, 46, 156, 239),
        onPrimary: Color.fromARGB(255, 255, 245, 54),
        secondary: Color.fromARGB(255, 50, 213, 96),
        onSecondary: Colors.purple,
        error: Color.fromARGB(255, 255, 56, 56),
        onError: Colors.brown,
        surface: Color.fromARGB(255, 19, 33, 63),
        onSurface: Color.fromARGB(255, 242, 245, 255),
        background: Color.fromARGB(255, 18, 19, 19),
        onBackground: Color.fromARGB(255, 40, 94, 164),
      ),
    );
  }
}