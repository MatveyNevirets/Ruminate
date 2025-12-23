import 'package:ruminate/core/key_value_storage/data/datasource/key_value_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage implements KeyValueStorage {
  SharedPreferences? _sharedPreferences;

  Future<void> _initSharedPreferences() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

  @override
  Future<T?> readValue<T>(String key) async {
    try {
      if (_sharedPreferences == null) await _initSharedPreferences();

      final result = _sharedPreferences!.get(key);
      return result is T ? result : null;
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

  @override
  Future<void> writeBool(String key, bool value) async {
    try {
      if (_sharedPreferences == null) await _initSharedPreferences();

      await _sharedPreferences!.setBool(key, value);
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

  @override
  Future<void> writeInt(String key, int value) async {
    try {
      if (_sharedPreferences == null) await _initSharedPreferences();

      await _sharedPreferences!.setInt(key, value);
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

  @override
  Future<void> writeString(String key, String value) async {
    try {
      if (_sharedPreferences == null) await _initSharedPreferences();

      await _sharedPreferences!.setString(key, value);
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

  @override
  Future<void> deletePassword(String key) async {
    try {
      if (_sharedPreferences == null) await _initSharedPreferences();
      await _sharedPreferences!.remove(key);
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }
}
