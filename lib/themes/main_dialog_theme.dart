import 'package:flutter/material.dart';

//INFO: This Theme should be applied on all Dialog's, except Date Picker Dialogs
abstract class MainDialogTheme{

  static ThemeData build(BuildContext context){
    ThemeData enclosingTheme = Theme.of(context);
    return ThemeData(
      colorScheme: enclosingTheme.colorScheme.copyWith(
        onSurface: Colors.black,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        contentTextStyle: TextStyle(
          color: enclosingTheme.colorScheme.primaryContainer,
          fontSize: 18,
        ),
        titleTextStyle: TextStyle(
          color: enclosingTheme.colorScheme.primary,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      ),
      textTheme: enclosingTheme.textTheme
    );
  }
}