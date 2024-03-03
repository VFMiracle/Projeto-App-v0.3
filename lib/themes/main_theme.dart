import 'package:flutter/material.dart';

abstract class MainTheme{

  static ThemeData build(){
    return ThemeData(
      appBarTheme: const AppBarTheme(
        titleSpacing: 0
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color.fromARGB(255, 46, 156, 239), //INFO: Color Name: Celestial Blue
        onPrimary: Color.fromARGB(255, 7, 236, 217), //INFO: Color Name: Turquoise
        secondary: Color.fromARGB(255, 40, 76, 40), //INFO: Color Name: Sea Green
        onSecondary: Color.fromARGB(255, 50, 236, 65), //INFO: Color Name: SGBUS Green
        error: Color.fromARGB(255, 146, 25, 11), //INFO: Color Name: Penn Red
        onError: Color.fromARGB(255, 255, 54, 54), //INFO: Color Name: Vermilion
        surface: Color.fromARGB(255, 19, 33, 63), //INFO: Color Name: Oxford Blue
        onSurface: Color.fromARGB(255, 242, 245, 255), //INFO: Color Name: Ghost White
        background: Color.fromARGB(255, 18, 19, 19), //INFO: Color Name: Night
        onBackground: Color.fromARGB(255, 40, 94, 164), //INFO: Color Name: Lapis Lazuli
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
        ),
      ),
      textTheme: const TextTheme(
        //INFO: This Style is used on Text Fields and Text Form Fields.
        bodyLarge: TextStyle(
          color: Colors.amber,
          fontSize: 22,
        ),
        //INFO: This Style is used on the majority of simple text writtern throughout the App, including, but not limited to: Route warnings, Error Dialogs and Input labels.
        bodyMedium: TextStyle(
          color: Colors.amber,
          fontSize: 20,
        ),
        /* bodySmall: TextStyle(
          color: Colors.amber,
          fontSize: 16,
        ), */
        /*displayLarge: TextStyle(
          color: Colors.redAccent,
          fontSize: 40,
        ),
        displayMedium: TextStyle(
          color: Colors.redAccent,
          fontSize: 24,
        ),
        displaySmall: TextStyle(
          color: Colors.redAccent,
          fontSize: 16,
        ),*/
        //INFO: This Style is used for the Date Picker Weekday description in it's Header.
        headlineLarge: TextStyle(
          color: Colors.brown,
          fontSize: 38,
        ),
        /* headlineMedium: TextStyle(
          color: Colors.brown,
          fontSize: 24,
        ), */
        //INFO: This Style is used in Dialog Titles.
        headlineSmall: TextStyle(
          color: Colors.brown,
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
        //INFO: This Style is used for the Text on Text Buttons and the "Select Date" text on the Date Picker.
        labelLarge: TextStyle(
          color: Colors.lime,
          fontSize: 20,
        ),
        /* labelMedium: TextStyle(
          color: Colors.lime,
          fontSize: 24,
        ),
        labelSmall: TextStyle(
          color: Colors.lime,
          fontSize: 16,
        ), */
        titleLarge: TextStyle( //TEMP: Is used
          color: Colors.pink,
          fontSize: 30,
        ),
        titleMedium: TextStyle(
          color: Colors.pink,
          fontSize: 20,
        ),
        titleSmall: TextStyle(
          color: Colors.pink,
          fontSize: 16,
        ),
      )
    );
  }
}