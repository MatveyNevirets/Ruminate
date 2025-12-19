import 'package:ruminate/core/consts/app_consts.dart';
import 'package:ruminate/core/key_value_storage/data/datasource/key_value_storage.dart';
import 'package:ruminate/features/start/domain/repository/start_repository.dart';

class StartRepositoryImpl implements StartRepository {
  late final KeyValueStorage _startDatasource;

  StartRepositoryImpl({required KeyValueStorage startDatasource})
    : _startDatasource = startDatasource;

  @override
  Future<List<bool>> fetchStartValues() async {
    try {
      final isFirstEnterValue =
          await _startDatasource.readValue<bool>(AppConsts.isFirstEnterKey) ??
          true;
      final isHavePasswordValue =
          await _startDatasource.readValue<bool>(AppConsts.isHavePasswordKey) ??
          false;

      return <bool>[isFirstEnterValue, isHavePasswordValue];
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

  @override
  Future<void> setFirstValue(bool value) async {
    try {
      await _startDatasource.writeBool(AppConsts.isFirstEnterKey, value);
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

  @override
  Future<void> setHavePassword(bool value) async {
    try {
      await _startDatasource.writeBool(AppConsts.isHavePasswordKey, value);
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }
}
