import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/features/personal_victories/data/repository/victories_repository_impl.dart';
import 'package:ruminate/features/personal_victories/domain/repository/victories_repository.dart';
import 'package:ruminate/features/personal_victories/provider/victories_local_file_datasource_provider.dart';

final victoriesRepositoryProvider = Provider<VictoriesRepository>(
  (ref) => VictoriesRepositoryImpl(localVictoriesDatasource: ref.read(localVictoriesFileDatasourceProvider)),
);
