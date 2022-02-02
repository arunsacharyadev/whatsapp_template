import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_config.dart';

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
        appBarTheme: AppBarTheme(
          color: '#424242'.toHexColor(),
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          ),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: tealGreenLight,
        ),
        indicatorColor: tealGreenLight,
        toggleableActiveColor: tealGreenLight,
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: AppTheme.tealGreenLight),
      );

  static get lightTheme => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: 'FFFFFF'.toHexColor(),
        primaryColor: tealGreenDark,
        secondaryHeaderColor: tealGreenLight,
        appBarTheme: AppBarTheme(
          color: tealGreenDark,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: lightGreen,
        ),
        indicatorColor: 'FFFFFF'.toHexColor(),
        toggleableActiveColor: tealGreenLight,
        textSelectionTheme:
            TextSelectionThemeData(cursorColor: AppTheme.tealGreenLight),
      );
}
