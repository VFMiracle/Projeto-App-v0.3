import 'package:flutter/material.dart';

abstract class MainTheme{

  static ThemeData build(){
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color.fromARGB(255, 46, 156, 239), //INFO: Color Name: Celestial Blue
        onPrimary: Color.fromARGB(255, 7, 236, 217), //INFO: Color Name: Turquoise
        secondary: Color.fromARGB(255, 32, 131, 67), //INFO: Color Name: Sea Green
        onSecondary: Color.fromARGB(255, 50, 236, 65), //INFO: Color Name: SGBUS Green
        error: Color.fromARGB(255, 146, 25, 11), //INFO: Color Name: Penn Red
        onError: Color.fromARGB(255, 255, 54, 54), //INFO: Color Name: Vermilion
        surface: Color.fromARGB(255, 19, 33, 63), //INFO: Color Name: Oxford Blue
        onSurface: Color.fromARGB(255, 242, 245, 255), //INFO: Color Name: Ghost White
        background: Color.fromARGB(255, 18, 19, 19), //INFO: Color Name: Night
        onBackground: Color.fromARGB(255, 40, 94, 164), //INFO: Color Name: Lapis Lazuli
      ),
    );
  }
}