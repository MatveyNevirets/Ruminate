import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/themes/app_themes.dart';
import 'package:ruminate/features/profile/presentation/view_model/theme_change_view_model.dart';

class ThemeViewModel extends StateNotifier<int> {
  ThemeViewModel([super.initial = 0]);

  final themesCount = AppThemes.getThemes.length;

  void setTheme(int newIndex) {
    state = newIndex;
  }

  void toggle() {
    if (state != themesCount - 1) {
      state = state + 1;
    } else {
      state = 0;
    }
  }

  int get getThemeIndex => state;
}

final themeViewModelProvider = StateNotifierProvider<ThemeViewModel, int>(
  (ref) => ThemeViewModel(),
);

final themeProvider = Provider<ThemeData>((ref) {
  final themeChangeProvider = ref.watch(themeChangeViewModelProvider.notifier);
  themeChangeProvider.initState();
  final themeIndex = ref.watch(themeViewModelProvider);
  return AppThemes.getThemes[themeIndex];
});
