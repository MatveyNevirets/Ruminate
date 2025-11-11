import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/features/personal_victories/data/datasources/local/local_file_victories_datasource.dart';
import 'package:ruminate/features/personal_victories/data/datasources/local/local_victories_datasource.dart';

final localVictoriesFileDatasourceProvider = Provider<LocalVictoriesDatasource>(
  (ref) => LocalVictoriesFileDatasource(),
);
