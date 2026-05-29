import 'package:flutter/material.dart';

abstract class AppThemes {
  static const List<Color> _seedColors = [
    Color.fromARGB(255, 255, 255, 255), // white calm
    Color(0xFFE0A83C), // amber calm
    Color(0xFFE56B6F), // rose calm
    Color(0xFF4CAF7A), // green calm
    Color(0xFF5B8DEF), // blue calm
  ];

  static ThemeData _buildTheme(Color seed) {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ).copyWith(
          surface: const Color(0xFFF7F4EE),
          surfaceContainerLowest: const Color(0xFFFCFAF7),
          surfaceContainerLow: const Color(0xFFF7F2EB),
          surfaceContainer: const Color(0xFFF0EADF),
          surfaceContainerHigh: const Color(0xFFE8E1D7),
          surfaceContainerHighest: const Color(0xFFE1D8CD),
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surfaceContainerLowest,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surfaceContainerLowest,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
      ),
      splashFactory: InkSparkle.splashFactory,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.w700,
          height: 1.08,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          height: 1.12,
        ),
        headlineSmall: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          height: 1.18,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          height: 1.25,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.3,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.55,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.45,
        ),
        labelLarge: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.onSurface.withOpacity(0.08),
        thickness: 1,
      ),
    );
  }

  static final List<ThemeData> _themes = List.unmodifiable([
    _buildTheme(_seedColors[0]),
    _buildTheme(_seedColors[1]),
    _buildTheme(_seedColors[2]),
    _buildTheme(_seedColors[3]),
  ]);

  static List<ThemeData> get getThemes => _themes;
  static List<Color> get seedColors => _seedColors;
}
