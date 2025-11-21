import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/application/app_runner/app_env.dart';
import 'package:ruminate/application/provider/app_env_provider.dart';
import 'package:ruminate/features/personal_victories/data/datasources/local/local_victories_datasource.dart';
import 'package:ruminate/features/personal_victories/data/datasources/local/local_victories_file_datasource.dart';
import 'package:ruminate/features/personal_victories/data/datasources/local/mock_local_victories_datasource.dart';

final localVictoriesFileDatasourceProvider = Provider<LocalVictoriesDatasource>(
  (ref) => switch (ref.read(appEnvProvider)) {
    AppEnv.test => MockLocalVictoriesFileDatasource(),
    AppEnv.prod => LocalVictoriesFileDatasource(),
  },
);
