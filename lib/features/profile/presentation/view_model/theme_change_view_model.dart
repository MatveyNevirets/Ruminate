import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/consts/app_consts.dart';
import 'package:ruminate/core/key_value_storage/data/datasource/key_value_storage.dart';
import 'package:ruminate/core/key_value_storage/providers/key_value_storage_provider.dart';
import 'package:ruminate/core/themes/app_themes.dart';
import 'package:ruminate/core/view_models/theme_view_model.dart';

class ThemeChangeViewModel extends StateNotifier<List<bool>> {
  final _themes = AppThemes.getThemes;

  final KeyValueStorage _keyValueStorage;
  final ThemeViewModel _themeViewModel;

  // Here we have data
  // That have the list of buttons state
  // Activated or not
  List<bool> _buttonsActiveStates = [];

  ThemeChangeViewModel(this._themeViewModel, this._keyValueStorage) : super([]);

  // Returns true is success
  // And returns false if state is fail
  Future<bool> initState() async {
    try {
      final savedThemeIndex = await _keyValueStorage.readValue<int>(
        AppConsts.currentThemeIndexKey,
      );
      changeTheme(savedThemeIndex ?? 0);
      return true;
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

  void changeTheme(int index) {
    // Here we change button's active state
    _buttonsActiveStates = List.generate(_themes.length, (int index) => false);
    _buttonsActiveStates[index] = true;

    // Write our index into storage
    // To recieve this one
    // When we start an App again
    _keyValueStorage.writeInt(AppConsts.currentThemeIndexKey, index);

    // Change theme
    // And shows it to user
    _themeViewModel.setTheme(index);
    state = _buttonsActiveStates;
  }
}

final themeChangeViewModelProvider =
    StateNotifierProvider<ThemeChangeViewModel, List<bool>>(
      (ref) => ThemeChangeViewModel(
        ref.watch(themeViewModelProvider.notifier),
        ref.watch(keyValueStorageProvider),
      ),
    );
