abstract class PasswordRepository {
  Future<String?> recievePassword();
  Future<void> writePassword(String value);
}
