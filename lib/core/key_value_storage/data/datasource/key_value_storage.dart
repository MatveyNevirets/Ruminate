abstract class KeyValueStorage {
  Future<T?> readValue<T>(String key);
  Future<void> writeBool(String key, bool value);
  Future<void> writeString(String key, String value);
  Future<void> writeInt(String key, int value);
}
