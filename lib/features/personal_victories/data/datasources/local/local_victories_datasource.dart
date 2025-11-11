import 'dart:async';

abstract class LocalVictoriesDatasource {
  FutureOr<List<String>> fetchVictories();
  Future<void> addVictories(List<String> victories);
  Future<void> initDatasource();
}
