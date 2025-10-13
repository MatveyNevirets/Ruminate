import 'package:flutter/material.dart';

abstract class AppThemes {
  static final _themes = List.unmodifiable([
    ThemeData.light().copyWith(colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber)),
    ThemeData.light().copyWith(colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
    ThemeData.light().copyWith(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
    ThemeData.dark().copyWith(colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber)),
    ThemeData.dark().copyWith(colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
    ThemeData.dark().copyWith(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
  ]);

  static get getThemes => _themes;
}
