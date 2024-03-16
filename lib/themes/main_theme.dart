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
        onPrimary: Color.fromARGB(255, 0, 64, 167), //INFO: Color Name: Cobalt Blue
        secondary: Color.fromARGB(255, 4, 76, 98), //INFO: Color Name: Midnight Green
        onSecondary: Color.fromARGB(255, 55, 238, 251), //INFO: Color Name: Eletric Blue
        tertiary: Color.fromARGB(255, 40, 76, 40), //INFO: Color Name: Cal Poly Green
        onTertiary: Color.fromARGB(255, 50, 236, 65), //INFO: Color Name: SGBUS Green
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
        //INFO: This Style is used for the text on Text Fields and Text Form Fields.
        bodyLarge: TextStyle(
          fontSize: 20,
        ),
        //INFO: This Style is used on the majority of simple text writtern throughout the App, including, but not limited to: Route warnings, Error Dialogs and Input labels.
        bodyMedium: TextStyle(
          fontSize: 18,
        ),
        //INFO: This Style is used for the Date Picker's Weekday description in it's Header.
        headlineLarge: TextStyle(
          fontSize: 38,
        ),
        //INFO: This Style is used in Dialog Titles.
        headlineSmall: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
        //INFO: This Style is used for the Text on Text Buttons and the "Select Date" text on the Date Picker.
        labelLarge: TextStyle(
          fontSize: 20,
        ),
        //INFO: This Style is used for the Titles of the Routes.
        titleLarge: TextStyle(
          fontSize: 28,
        ),
        //INFO: This Style is used for the entries of a Dropdown Button, regardless of whether they're selected or not, the height of a Text Form Field, independently of it's
        //  text size, and the size of a Text Field's Hint Text.
        titleMedium: TextStyle(
          fontSize: 20,
        ),
        //INFO: This Style is used on the Date Picker's month selector.
        titleSmall: TextStyle(
          fontSize: 20,
        ),
      )
    );
  }
}