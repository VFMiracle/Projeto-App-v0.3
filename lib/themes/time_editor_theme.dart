import 'package:flutter/material.dart';

abstract class TimeEditorTheme{

  static ThemeData build(BuildContext context){
    return ThemeData(
      textTheme: TextTheme(
        headlineMedium: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 15,
        ),
        titleLarge: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 22,
        ),
        titleMedium: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}