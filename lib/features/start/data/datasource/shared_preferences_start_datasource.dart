import 'dart:developer';

import 'package:ruminate/core/consts/start_consts.dart';
import 'package:ruminate/features/start/data/datasource/start_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStartDatasource implements StartDatasource {
  SharedPreferences? _sharedPreferences;

  Future<void> _initSharedPreferences() async {
    try {
      log(_sharedPreferences.toString());
      _sharedPreferences = await SharedPreferences.getInstance();
      log(_sharedPreferences.toString());
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

  @override
  Future<List<bool>> fetchStartValues() async {
    try {
      log("Try fetch");
      if (_sharedPreferences == null) {
        log("await");
        await _initSharedPreferences();
      }

      final isFirstEnter =
          _sharedPreferences?.getBool(StartConsts.isFirstEnterKey) ?? true;
      final isHavePassword =
          _sharedPreferences?.getBool(StartConsts.isHavePassword) ?? false;

      log("$isFirstEnter $isHavePassword");

      return [true, isHavePassword];
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

  @override
  Future<void> setFirstEnter(bool value) async {
    try {
      if (_sharedPreferences == null) await _initSharedPreferences();

      await _sharedPreferences!.setBool(StartConsts.isFirstEnterKey, value);
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

  @override
  Future<void> setHavePassword(bool value) async {
    try {
      if (_sharedPreferences == null) await _initSharedPreferences();

      await _sharedPreferences!.setBool(StartConsts.isHavePassword, value);
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }
}
