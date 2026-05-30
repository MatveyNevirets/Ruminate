import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/consts/app_consts.dart';
import 'package:ruminate/core/key_value_storage/data/datasource/key_value_storage.dart';
import 'package:ruminate/core/key_value_storage/providers/key_value_storage_provider.dart';
import 'package:ruminate/core/themes/app_themes.dart';
import 'package:ruminate/core/view_models/theme_view_model.dart';
import 'package:ruminate/features/start/presentation/view_model/start_view_model.dart';

class SettingsViewModel extends StateNotifier<List<bool>> {
  SettingsViewModel(
    this._themeViewModel,
    this._keyValueStorage,
    this._startViewModel,
  ) : super(
        List<bool>.filled(AppThemes.getThemes.length, false, growable: false),
      ) {
    _buttonsActiveStates = List<bool>.filled(
      _themes.length,
      false,
      growable: false,
    );
  }

  final List<ThemeData> _themes = AppThemes.getThemes;
  final KeyValueStorage _keyValueStorage;
  final ThemeViewModel _themeViewModel;
  final StartViewModel _startViewModel;

  List<bool> _buttonsActiveStates = [];

  int _normalizeIndex(int index) {
    if (_themes.isEmpty) return 0;
    if (index < 0) return 0;
    if (index >= _themes.length) return _themes.length - 1;
    return index;
  }

  void _applyTheme(int index, {required bool persist}) {
    if (_themes.isEmpty) return;

    final safeIndex = _normalizeIndex(index);

    _buttonsActiveStates = List<bool>.filled(
      _themes.length,
      false,
      growable: false,
    );
    _buttonsActiveStates[safeIndex] = true;
    state = List<bool>.unmodifiable(_buttonsActiveStates);

    _themeViewModel.setTheme(safeIndex);

    if (persist) {
      _keyValueStorage.writeInt(AppConsts.currentThemeIndexKey, safeIndex);
    }
  }

  Future<bool> initState() async {
    try {
      final savedThemeIndex = await _keyValueStorage.readValue<int>(
        AppConsts.currentThemeIndexKey,
      );

      _applyTheme(savedThemeIndex ?? 0, persist: false);
      return true;
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

  Future<bool> isPasswordExistsCheck() async {
    final result = await _keyValueStorage.readValue<bool>(
      AppConsts.isPasswordExistsKey,
    );
    return result ?? false;
  }

  Future<bool> deletePassword() async {
    try {
      await _keyValueStorage.deletePassword(AppConsts.localPasswordKey);
      await _startViewModel.setHavePassword(false);
      return true;
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

  void changeTheme(int index) {
    _applyTheme(index, persist: true);
  }
}

final settingsViewModelProvider =
    StateNotifierProvider<SettingsViewModel, List<bool>>(
      (ref) => SettingsViewModel(
        ref.watch(themeViewModelProvider.notifier),
        ref.watch(keyValueStorageProvider),
        ref.watch(startViewModelProvider.notifier),
      ),
    );
