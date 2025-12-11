import 'dart:developer';

import 'package:ruminate/features/start_screen/data/datasource/start_datasource.dart';

class SharedPreferencesStartDatasource implements StartDatasource {
  @override
  Future<List<bool>> fetchStartValues() async {
    await Future.delayed(Duration(seconds: 1));

    // HERE WE FETCH OUR VALUES

    // HERE WE SAYS THAT FIRST VALUE IS FIRST START AND THE SECOND IS HAVE PASSWORD
    return [true, false];
  }

  @override
  Future<void> setFirstEnter(bool value) async {
    log('Value of first enter has been changed to $value');
  }

  @override
  Future<void> setHavePassword(bool value) async {
    log('Value of have password has been changed to $value');
  }
}
