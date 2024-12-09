import 'package:digits_app/themes/app_pallete.dart';
import 'package:flutter/material.dart';


class AppTheme{
  static _border(Color color) => OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: 3
    ),
    borderRadius: BorderRadius.circular(10)
  );
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      focusedBorder: _border(Colors.greenAccent.withOpacity(0.2)),
      enabledBorder: _border(Pallete.borderColor),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Pallete.backgroundColor
    )
  );
  
}