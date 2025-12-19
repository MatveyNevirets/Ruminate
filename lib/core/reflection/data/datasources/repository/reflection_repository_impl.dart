import 'dart:async';

import 'package:ruminate/core/reflection/data/datasources/local/local_reflection_datasource.dart';
import 'package:ruminate/core/reflection/data/model/reflection_model.dart';
import 'package:ruminate/core/reflection/domain/reflection_repository.dart';

class ReflectionRepositoryImpl implements ReflectionRepository {
  final LocalReflectionDatasource localReflectionDatasource;

  ReflectionRepositoryImpl({required this.localReflectionDatasource});

  @override
  Future<List<ReflectionModel>?> fetchAllReflections() async {
    try {
      final result = await localReflectionDatasource.fetchAllReflections();
      return result;
    } on Exception catch (e, stack) {
      throw Exception(
        "Exception at ReflectionDatasourceRepositoryImpl in method fetchAllReflections(): $e StackTrace: $stack",
      );
    }
  }

  @override
  Future<void> insertReflection(ReflectionModel reflection) async {
    try {
      await localReflectionDatasource.insertReflection(reflection);
    } on Exception catch (e, stack) {
      throw Exception(
        "Exception at ReflectionDatasourceRepositoryImpl in method insertReflection(): $e StackTrace: $stack",
      );
    }
  }
}
