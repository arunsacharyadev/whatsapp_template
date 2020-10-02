import 'package:flutter/material.dart';
import 'package:whatsapp_template/app_utils/color_config.dart';

class AppTheme {
  static Color tealGreenDark = '075E54'.toHexColor();
  static Color tealGreenLight = '128C7E'.toHexColor();
  static Color lightGreen = '25D366'.toHexColor();
  static Color chatBackground = 'ECE5DD'.toHexColor();
  static Color checkMarkBlue = '34B7F1'.toHexColor();
  static Color greyColor = Colors.grey;
  static Color redAccent = Colors.redAccent;

  static get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: '#303030'.toHexColor(),
        primaryColor: tealGreenDark,
        secondaryHeaderColor: tealGreenLight,
        accentColor: lightGreen,
        accentColorBrightness: Brightness.dark,
        accentIconTheme: IconThemeData(
          color: chatBackground,
        ),
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          color: '#424242'.toHexColor(),
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: tealGreenLight,
        ),
        indicatorColor: tealGreenLight,
        toggleableActiveColor: tealGreenLight,
        cursorColor: AppTheme.tealGreenLight,
      );

  static get lightTheme => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: 'FFFFFF'.toHexColor(),
        primaryColor: tealGreenDark,
        secondaryHeaderColor: tealGreenLight,
        accentColor: lightGreen,
        accentIconTheme: IconThemeData(
          color: tealGreenLight,
        ),
        accentColorBrightness: Brightness.light,
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          color: tealGreenDark,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: lightGreen,
        ),
        indicatorColor: 'FFFFFF'.toHexColor(),
        toggleableActiveColor: tealGreenLight,
        cursorColor: AppTheme.tealGreenLight,
      );
}
