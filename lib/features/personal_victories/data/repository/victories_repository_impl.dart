import 'dart:async';

import 'package:ruminate/features/personal_victories/data/datasources/local/local_victories_datasource.dart';
import 'package:ruminate/features/personal_victories/domain/repository/victories_repository.dart';

class VictoriesRepositoryImpl implements VictoriesRepository {
  final LocalVictoriesDatasource localVictoriesDatasource;

  VictoriesRepositoryImpl({required this.localVictoriesDatasource});

  @override
  Future<void> addVictories(List<String> victories) async {
    await localVictoriesDatasource.addVictories(victories);
  }

  @override
  Future<List<String>> fetchVictories() async {
    return await localVictoriesDatasource.fetchVictories();
  }
}
