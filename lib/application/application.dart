// application.dart
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/application/routes.dart';
import 'package:ruminate/core/providers/start_provider.dart';
import 'package:ruminate/core/themes/app_themes.dart';
import 'package:ruminate/core/view_models/theme_view_model.dart';

class Application extends ConsumerWidget {
  const Application({super.key});

  ThemeData _lightThemeFromSelected(ThemeData selectedTheme) {
    final seed = AppThemes.seedOf(selectedTheme);
    return AppThemes.lightTheme(seed);
  }

  ThemeData _darkThemeFromSelected(ThemeData selectedTheme) {
    final seed = AppThemes.seedOf(selectedTheme);
    return AppThemes.darkTheme(seed);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startFutureRepository = ref.watch(startDataProvider);
    final selectedTheme = ref.watch(themeProvider);

    final lightTheme = _lightThemeFromSelected(selectedTheme);
    final darkTheme = _darkThemeFromSelected(selectedTheme);

    final platformBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final previewTheme = platformBrightness == Brightness.dark
        ? darkTheme
        : lightTheme;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: platformBrightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
        statusBarBrightness: platformBrightness == Brightness.dark
            ? Brightness.dark
            : Brightness.light,
      ),
    );

    return startFutureRepository.when(
      data: (data) {
        final routerConfig = ref.read(routerConfigProvider);

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: routerConfig,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.system,
        );
      },
      error: (e, stack) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.system,
          home: Scaffold(
            backgroundColor: previewTheme.scaffoldBackgroundColor,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 44,
                      color: previewTheme.colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Не удалось запустить приложение",
                      textAlign: TextAlign.center,
                      style: previewTheme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Попробуй перезапустить приложение позже.",
                      textAlign: TextAlign.center,
                      style: previewTheme.textTheme.bodyMedium?.copyWith(
                        color: previewTheme.colorScheme.onSurface.withOpacity(
                          0.65,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      loading: () {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.system,
          home: Scaffold(
            backgroundColor: previewTheme.scaffoldBackgroundColor,
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Ruminate",
                    style: previewTheme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: previewTheme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: previewTheme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
