import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/data/datasources/repository/reflection_repository_impl.dart';
import 'package:ruminate/core/data/providers/local_file_datasource_provider.dart';
import 'package:ruminate/core/domain/reflection_repository.dart';

final reflectionRepositoryProvider = Provider<ReflectionRepository>(
  (ref) => ReflectionRepositoryImpl(localReflectionDatasource: ref.read(localFileDataSourceProvider)),
);
