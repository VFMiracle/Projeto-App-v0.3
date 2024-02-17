import 'package:flutter/material.dart';

//INFO: This Theme should be applied on all Dialog's, except Date Picker Dialogs
abstract class MainDialogTheme{

  static DialogTheme build(Color contentColor, Color titleColor){
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
  }
}