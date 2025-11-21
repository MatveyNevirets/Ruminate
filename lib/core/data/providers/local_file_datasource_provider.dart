import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/application/app_runner/app_env.dart';
import 'package:ruminate/application/provider/app_env_provider.dart';
import 'package:ruminate/core/data/datasources/local/local_file_reflection_datasource.dart';
import 'package:ruminate/core/data/datasources/local/local_reflection_datasource.dart';
import 'package:ruminate/core/data/datasources/local/mock_local_file_reflection_datasource.dart';
import 'package:ruminate/core/providers/path_service_provider.dart';

final localFileDataSourceProvider = Provider<LocalReflectionDatasource>(
  (ref) => switch (ref.read(appEnvProvider)) {
    AppEnv.prod => LocalFileReflectionDataSource(pathService: ref.read(pathServiceProvider)),
    AppEnv.test => MockLocalFileReflectionDataSource(),
  },
);
