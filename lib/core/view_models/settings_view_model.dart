import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/consts/app_consts.dart';
import 'package:ruminate/core/key_value_storage/data/datasource/key_value_storage.dart';
import 'package:ruminate/core/key_value_storage/providers/key_value_storage_provider.dart';
import 'package:ruminate/core/themes/app_themes.dart';
import 'package:ruminate/core/view_models/theme_view_model.dart';
import 'package:ruminate/features/start/presentation/view_model/start_view_model.dart';

class SettingsViewModel extends StateNotifier<List<bool>> {
  final _themes = AppThemes.getThemes;

  final KeyValueStorage _keyValueStorage;
  final ThemeViewModel _themeViewModel;
  final StartViewModel _startViewModel;

  // Here we have data
  // That have the list of buttons state
  // Activated or not
  List<bool> _buttonsActiveStates = [];

  SettingsViewModel(
    this._themeViewModel,
    this._keyValueStorage,
    this._startViewModel,
  ) : super([]);

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

  // This method helps recieve data about password
  // That we can shows to user the actual state of buttuns
  Future<bool> isPasswordExistsCheck() async {
    // Fetch is
    final result = await _keyValueStorage.readValue<bool>(
      AppConsts.isPasswordExistsKey,
    );

    // Returns result and fallback value
    // If we'll catch some error
    return result ?? false;
  }

  // When method of delete the password is success
  // Returns true that we'll can show
  // To user the snackbar
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

final settingsViewModelProvider =
    StateNotifierProvider<SettingsViewModel, List<bool>>(
      (ref) => SettingsViewModel(
        ref.watch(themeViewModelProvider.notifier),
        ref.watch(keyValueStorageProvider),
        ref.watch(startViewModelProvider.notifier),
      ),
    );
