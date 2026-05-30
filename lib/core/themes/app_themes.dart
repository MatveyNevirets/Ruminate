// app_themes.dart
import 'package:flutter/material.dart';

class ThemeSeedExtension extends ThemeExtension<ThemeSeedExtension> {
  const ThemeSeedExtension({required this.seedColor});

  final Color seedColor;

  @override
  ThemeSeedExtension copyWith({Color? seedColor}) {
    return ThemeSeedExtension(
      seedColor: seedColor ?? this.seedColor,
    );
  }

  @override
  ThemeExtension<ThemeSeedExtension> lerp(
    covariant ThemeExtension<ThemeSeedExtension>? other,
    double t,
  ) {
    if (other is! ThemeSeedExtension) return this;
    return ThemeSeedExtension(
      seedColor: Color.lerp(seedColor, other.seedColor, t) ?? seedColor,
    );
  }
}

abstract class AppThemes {
  static const List<Color> seedColors = [
    Color.fromARGB(255, 255, 255, 255), // white calm
    Color(0xFFE0A83C), // amber calm
    Color(0xFFE56B6F), // rose calm
    Color(0xFF4CAF7A), // green calm
    Color(0xFF5B8DEF), // blue calm
  ];

  static ThemeData _buildTheme(Color seed, Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    ).copyWith(
      surface: isDark ? const Color(0xFF151515) : const Color(0xFFF7F4EE),
      surfaceContainerLowest:
          isDark ? const Color(0xFF101010) : const Color(0xFFFCFAF7),
      surfaceContainerLow:
          isDark ? const Color(0xFF171717) : const Color(0xFFF7F2EB),
      surfaceContainer:
          isDark ? const Color(0xFF1D1D1D) : const Color(0xFFF0EADF),
      surfaceContainerHigh:
          isDark ? const Color(0xFF242424) : const Color(0xFFE8E1D7),
      surfaceContainerHighest:
          isDark ? const Color(0xFF2B2B2B) : const Color(0xFFE1D8CD),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
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
      extensions: <ThemeExtension<dynamic>>[
        ThemeSeedExtension(seedColor: seed),
      ],
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
      ).apply(
        bodyColor: scheme.onSurface,
        displayColor: scheme.onSurface,
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: scheme.onSurface.withOpacity(isDark ? 0.12 : 0.08),
        thickness: 1,
      ),
    );
  }

  static ThemeData lightTheme(Color seed) =>
      _buildTheme(seed, Brightness.light);

  static ThemeData darkTheme(Color seed) =>
      _buildTheme(seed, Brightness.dark);

  static final List<ThemeData> _themes = List.generate(
    seedColors.length,
    (index) => lightTheme(seedColors[index]),
  );

  static List<ThemeData> get getThemes => _themes;
  static List<Color> get seedColorsList => seedColors;

  static Color seedOf(ThemeData theme) {
    return theme.extension<ThemeSeedExtension>()?.seedColor ??
        theme.colorScheme.primary;
  }
}