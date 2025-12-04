import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/application/app_runner/app_env.dart';
import 'package:ruminate/application/provider/app_env_provider.dart';
import 'package:ruminate/features/statistics/data/datasources/local/local_file_statistics_datasource.dart';
import 'package:ruminate/features/statistics/data/datasources/local/local_statistics_datasource.dart';
import 'package:ruminate/features/statistics/data/datasources/local/mock_local_file_statistics_datasource.dart';

final localStatisticsDatasourceProvider = Provider<LocalStatisticsDatasource>(
  (ref) => switch (ref.read(appEnvProvider)) {
    AppEnv.prod => LocalFileStatisticsDatasource(),
    AppEnv.test => MockLocalFileStatisticsDatasource(),
  },
);
