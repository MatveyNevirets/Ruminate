import 'package:ruminate/core/consts/app_consts.dart';
import 'package:ruminate/core/key_value_storage/data/datasource/key_value_storage.dart';
import 'package:ruminate/features/intro/domain/repository/password_repository.dart';

class PasswordRepositoryImpl implements PasswordRepository {
  final KeyValueStorage _keyValueStorage;

  PasswordRepositoryImpl({required KeyValueStorage keyValueStorage})
    : _keyValueStorage = keyValueStorage;

  @override
  Future<String?> recievePassword() async {
    try {
      final result = await _keyValueStorage.readValue<String>(
        AppConsts.localPasswordKey,
      );
      return result;
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

  @override
  Future<void> writePassword(String value) async {
    try {
      await _keyValueStorage.writeString(AppConsts.localPasswordKey, value);
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }
}
