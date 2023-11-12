import 'package:flutter/material.dart';

abstract class MyDialogTheme{

  static ThemeData build(BuildContext context){
    return ThemeData(
      textTheme: TextTheme(
        labelMedium: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 16,
        ),
        titleMedium: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 22,
        ),
      ),
    );
  }
}