import 'dart:async';

abstract class LocalVictoriesDatasource {
  FutureOr<List<String>?> fetchVictories();
  Future<void> insertVictories(List<String> victories);
  Future<void> initDatasource();
}
