import 'dart:async';
import 'dart:developer';


import 'package:ruminate/core/domain/reflection_repository.dart';
import 'package:ruminate/features/personal_victories/domain/repository/victories_repository.dart';
import 'package:ruminate/features/statistics/data/datasources/local/local_statistics_datasource.dart';
import 'package:ruminate/features/statistics/data/models/statistics_model.dart';
import 'package:ruminate/features/statistics/domain/repository/statistics_repository.dart';

class StatisticsRepositoryImpl implements StatisticsRepository {
  const StatisticsRepositoryImpl({
    required this.localStatisticsDatasource,
    required this.victoriesRepository,
    required this.reflectionRepsoitory,
  });

  final LocalStatisticsDatasource localStatisticsDatasource;
  final VictoriesRepository victoriesRepository;
  final ReflectionRepository reflectionRepsoitory;

  @override
  Future<void> insertData(StatisticsModel model) async {
    try {
      final reflections = await reflectionRepsoitory.fetchAllReflections();
      final victories = await victoriesRepository.fetchVictories();

      final newModel = model.copyWith(
        totalReflections: reflections?.length ?? 0,
        totalVictories: victories?.length ?? 0,
      );
      log(newModel.toString());

      await localStatisticsDatasource.insertData(newModel);
    } on Object catch (e, stack) {
      throw Exception("Exception $e StackTrace: $stack");
    }
  }

  @override
  FutureOr<List<StatisticsModel>?> fetchData() async {
    try {
      final statisticsList = await localStatisticsDatasource.fetchData();

      return statisticsList;
    } on Object catch (e, stack) {
      throw Exception("Exception $e StackTrace: $stack");
    }
  }
}
