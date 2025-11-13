import 'dart:async';

import 'package:ruminate/features/personal_victories/data/datasources/local/local_victories_datasource.dart';
import 'package:ruminate/features/personal_victories/domain/repository/victories_repository.dart';

class VictoriesRepositoryImpl implements VictoriesRepository {
  final LocalVictoriesDatasource localVictoriesDatasource;

  VictoriesRepositoryImpl({required this.localVictoriesDatasource});

  @override
  Future<void> insertVictories(List<String> victories) async {
    await localVictoriesDatasource.insertVictories(victories);
  }

  @override
  Future<List<String>?> fetchVictories() async {
    return await localVictoriesDatasource.fetchVictories();
  }
}
