import 'package:flutter/material.dart';

//INFO: This Theme should be applied on all Dialog's, except Date Picker Dialogs
abstract class OldMainDialogTheme{

  static DialogTheme build(Color textColor, Color backgroundColor){
    return DialogTheme(
      backgroundColor: backgroundColor,
      contentTextStyle: TextStyle(
        color: textColor,
        fontSize: 18,
      ),
      titleTextStyle: TextStyle(
        color: textColor,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}