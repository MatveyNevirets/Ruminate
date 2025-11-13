import 'dart:async';

abstract class VictoriesRepository {
  Future<void> insertVictories(List<String> victories);
  FutureOr<List<String>?> fetchVictories();
}
