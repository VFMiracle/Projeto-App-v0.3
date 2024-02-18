import 'package:flutter/material.dart';

abstract class TimeEditorTheme{

  static ThemeData build(BuildContext context){
    return Theme.of(context).copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(
        background: Colors.white,
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 20
        ),
        headlineMedium: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 18,
          fontWeight: FontWeight.w500
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