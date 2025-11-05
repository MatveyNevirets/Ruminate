import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/themes/app_themes.dart';

class ThemeIndexViewModel extends StateNotifier<int> {
  ThemeIndexViewModel([super.initial = 0]);

  final themesCount = AppThemes.getThemes.length;

  void setIndex(int newIndex) {
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
