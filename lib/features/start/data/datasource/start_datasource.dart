abstract class StartDatasource {
  Future<List<bool>> fetchStartValues();
  Future<void> setFirstEnter(bool value);
  Future<void> setHavePassword(bool value);
}
