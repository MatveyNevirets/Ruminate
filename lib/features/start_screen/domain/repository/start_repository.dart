abstract class StartRepository {
  Future<List<bool>> fetchStartValues();
  Future<void> setFirstValue(bool value);
  Future<void> setHavePassword(bool value);
}