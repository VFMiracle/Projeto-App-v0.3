import 'package:flutter/material.dart';

abstract class MainTheme{
  
  static ThemeData build(){
    Color primaryColor = const Color.fromARGB(255, 11, 79, 206);
    Color secondaryColor = const Color.fromARGB(255, 7, 146, 211);
    Color structureColor = const Color.fromARGB(255, 6, 24, 83);
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: const Color.fromARGB(255, 55, 90, 131),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onTertiary: Colors.white,
        error: const Color.fromARGB(255, 128, 13, 13),
        onError: Colors.red[500]!,
        background: Colors.white,
        onBackground: Colors.black,
        surface: structureColor,
        onSurface: const Color.fromARGB(255, 10, 99, 158),
      ),
      dialogTheme: DialogTheme(
        titleTextStyle: TextStyle(
          color: primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        )
      ),
      dividerTheme: DividerThemeData(
        color: structureColor,
        space: 0,
        thickness: 2,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          color: primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(
          color: primaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w500
        ),
        bodySmall: const TextStyle( //<- INFO: This style is implicitly used for the dates in the Date Picker.
          fontSize: 15,
        ),
        displayMedium: const TextStyle(
          fontSize: 30,
        ),
        displaySmall: TextStyle(
          color: secondaryColor,
          fontSize: 16,
        ),
        headlineLarge: const TextStyle(
          fontSize: 80,
          fontWeight: FontWeight.normal
        ),
        headlineMedium: TextStyle(
          color: primaryColor,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}