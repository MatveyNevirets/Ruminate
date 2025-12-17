import 'package:flutter/material.dart';

abstract class AppThemes {
  static const List<Color> _seedColors = [
    Colors.amber,
    Colors.red,
    Colors.green,
  ];

  static final _themes = List.unmodifiable([
    ThemeData.light().copyWith(
      scaffoldBackgroundColor: ColorScheme.fromSeed(
        seedColor: _seedColors[0],
      ).surfaceContainer,
      colorScheme: ColorScheme.fromSeed(seedColor: _seedColors[0]),
      textTheme: TextTheme(
        headlineLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
    ),
    ThemeData.light().copyWith(
      scaffoldBackgroundColor: ColorScheme.fromSeed(
        seedColor: _seedColors[1],
      ).surfaceContainer,
      colorScheme: ColorScheme.fromSeed(seedColor: _seedColors[1]),
      textTheme: TextTheme(
        headlineLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
    ),
    ThemeData.light().copyWith(
      scaffoldBackgroundColor: ColorScheme.fromSeed(
        seedColor: _seedColors[2],
      ).surfaceContainer,
      colorScheme: ColorScheme.fromSeed(seedColor: _seedColors[2]),
      textTheme: TextTheme(
        headlineLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        bodyLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
    ),
  ]);

  static get getThemes => _themes;
}
