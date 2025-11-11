import 'dart:async';

abstract class VictoriesRepository {
  Future<void> addVictories(List<String> victories);
  FutureOr<List<String>> fetchVictories();
}
