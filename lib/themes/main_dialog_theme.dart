import 'package:flutter/material.dart';

abstract class MainDialogTheme{

  static DialogTheme build({required Color contentColor, required Color titleColor}){
    return DialogTheme(
      backgroundColor: Colors.white,
      contentTextStyle: TextStyle(
        color: contentColor,
        fontSize: 18,
      ),
      titleTextStyle: TextStyle(
        color: titleColor,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    );
    /*return ThemeData(
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
    );*/
  }
}