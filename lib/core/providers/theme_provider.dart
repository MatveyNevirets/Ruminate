import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/themes/app_themes.dart';

class ThemeIndexNotifier extends StateNotifier<int> {
  ThemeIndexNotifier([super.initial = 0]);

  final themesCount = AppThemes.getThemes.length;

  void setIndex(int newIndex) {
    state = newIndex;
  }

  void toogle() {
    if (state != themesCount - 1) {
      state = state + 1;
    } else {
      state = 0;
    }
  }

  int get getThemeIndex => state;
}

final themeIndexProvider = StateNotifierProvider<ThemeIndexNotifier, int>((ref) => ThemeIndexNotifier());

final themeProvider = Provider<ThemeData>((ref) {
  final themeIndex = ref.watch(themeIndexProvider);
  return AppThemes.getThemes[themeIndex];
});
