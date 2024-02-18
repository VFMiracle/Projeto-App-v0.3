import 'package:flutter/material.dart';
import 'package:projeto_time_counter/themes/main_dialog_theme.dart';

abstract class MainTheme{
  
  static ThemeData build(){
    Color confirmColor = const Color.fromARGB(255, 21, 190, 27);
    Color errorColor = const Color.fromARGB(255, 218, 12, 12);
    Color primaryColor = const Color.fromARGB(255, 11, 79, 206);
    Color secondaryColor = const Color.fromARGB(255, 26, 167, 233);
    Color structureColor = const Color.fromARGB(255, 2, 16, 59);
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: const Color.fromARGB(255, 55, 90, 131),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onTertiary: Colors.white,
        error: errorColor,
        onError: const Color.fromARGB(255, 105, 28, 28),
        background: Colors.white,
        onBackground: const Color.fromARGB(255, 6, 33, 119),
        surface: primaryColor,
        onSurface: Colors.white,
        primaryContainer: structureColor,
        scrim: confirmColor,
      ),
      datePickerTheme: DatePickerThemeData(
        cancelButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(errorColor),
        ),
        confirmButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(confirmColor)
        ),
        dayBackgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states){
          if(states.contains(MaterialState.selected)){
            return confirmColor;
          }
          return primaryColor;
        }),
        todayBackgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states){
          if(states.contains(MaterialState.selected)){
            return confirmColor;
          }
          return primaryColor;
        }),
        todayForegroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states){
          if(states.contains(MaterialState.selected)){
            return Colors.white;
          }
          return confirmColor;
        }),
      ),
      dialogTheme: MainDialogTheme.build(Colors.white, primaryColor),
      dividerTheme: DividerThemeData(
        color: structureColor,
        space: 0,
        thickness: 2,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 114, 164, 255),
            width: 1.5,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
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
        bodySmall: const TextStyle(
          fontSize: 15,
        ),
        displayLarge: const TextStyle(
          fontSize: 80
        ),
        displayMedium: const TextStyle(
          fontSize: 30,
        ),
        displaySmall: TextStyle(
          color: secondaryColor,
          fontSize: 16,
        ),
        headlineLarge: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.normal
        ),
        headlineMedium: TextStyle(
          color: primaryColor,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        labelLarge: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}