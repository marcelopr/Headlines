import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _primaryColor = Colors.blue;
  static const Color _lightIconColor = Colors.black;
  static const Color _lightAccentIconColor = Colors.black54;
  static const Color _darkIconColor = Colors.white;
  static const Color _darkAccentIconColor = Colors.white54;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: _primaryColor,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: _lightIconColor),
    ),
    iconTheme: IconThemeData(color: _lightIconColor),
    accentIconTheme: IconThemeData(
      color: _lightAccentIconColor,
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: _primaryColor,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: _darkIconColor),
    ),
    iconTheme: IconThemeData(color: _darkIconColor),
    accentIconTheme: IconThemeData(
      color: _darkAccentIconColor,
    ),
  );
}
