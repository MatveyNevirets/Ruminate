import 'dart:async';
import 'dart:developer';

import 'package:ruminate/features/personal_victories/data/datasources/local/local_victories_datasource.dart';

class MockLocalVictoriesFileDatasource implements LocalVictoriesDatasource {
  bool? _directoryExists;
  List<String>? _cachedVictories;
  List<String>? _mockVictories;

  LocalVictoriesFileDatasource() {
    initDatasource();
  }

  @override
  Future<void> insertVictories(List<String> victories) async {
    try {
      await initDatasource();

      _mockVictories ??= [];

      //  Creates new list for victories
      final List<String> newVictories = [..._mockVictories!, ...victories];

      // Clear cache because the user must will see updated data
      _cachedVictories = null;

      _mockVictories = newVictories;
    } on Exception catch (e, stack) {
      throw Exception("Exception at LocalFileVictoriesDatasource, method addVictories(): $e StackTrace: $stack");
    }
  }

  @override
  FutureOr<List<String>?> fetchVictories() async {
    try {
      if (_cachedVictories == null) {
        await initDatasource();

        // Adds this one to cache
        _cachedVictories = _mockVictories;
      }

      // And in anyway we'll return the cache data
      log(_cachedVictories.toString());
      return _cachedVictories;
    } on Exception catch (e, stack) {
      throw Exception("Exception at LocalFileVictoriesDatasource in method fetchVictories(): $e StackTrace: $stack");
    }
  }

  @override
  Future<void> initDatasource() async {
    if (_directoryExists == null) {
      await Future.delayed(Duration(seconds: 2));

      _directoryExists = true;
    }
  }
}
