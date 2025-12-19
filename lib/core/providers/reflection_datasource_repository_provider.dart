import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/reflection/data/datasources/repository/reflection_repository_impl.dart';
import 'package:ruminate/core/reflection/data/providers/local_file_datasource_provider.dart';
import 'package:ruminate/core/reflection/domain/reflection_repository.dart';

final reflectionRepositoryProvider = Provider<ReflectionRepository>(
  (ref) => ReflectionRepositoryImpl(localReflectionDatasource: ref.read(localFileDataSourceProvider)),
);
