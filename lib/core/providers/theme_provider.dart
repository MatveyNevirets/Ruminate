import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/themes/app_themes.dart';
import 'package:ruminate/core/view_models/theme_view_model.dart';

final themeIndexProvider = StateNotifierProvider<ThemeIndexViewModel, int>((ref) => ThemeIndexViewModel());

final themeProvider = Provider<ThemeData>((ref) {
  final themeIndex = ref.watch(themeIndexProvider);
  return AppThemes.getThemes[themeIndex];
});
