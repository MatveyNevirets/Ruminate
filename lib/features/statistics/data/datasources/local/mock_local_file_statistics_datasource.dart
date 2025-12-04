import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:mocktail/mocktail.dart';
import 'package:ruminate/features/statistics/data/datasources/local/local_statistics_datasource.dart';
import 'package:ruminate/features/statistics/data/models/statistics_model.dart';

class MockLocalFileStatisticsDatasource extends Mock
    implements LocalStatisticsDatasource {
  List<StatisticsModel>? _mockData;

  @override
  Future<void> insertData(StatisticsModel model) async {
    await Future.delayed(Duration(seconds: 5));
    _mockData ??= [];

    final List<StatisticsModel> newStatistics = [
      ..._mockData!,
      ...[model],
    ];

    _mockData = newStatistics;

    print("$_mockData");
    print("Success!");
  }

  @override
  FutureOr<List<StatisticsModel>?> fetchData() async {
    print("Try to fetch $_mockData");
    return _mockData;
  }
}
