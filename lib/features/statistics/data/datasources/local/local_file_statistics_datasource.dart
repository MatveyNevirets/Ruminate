import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:ruminate/features/statistics/data/datasources/local/local_statistics_datasource.dart';
import 'package:ruminate/features/statistics/data/models/statistics_model.dart';

class LocalFileStatisticsDatasource implements LocalStatisticsDatasource {
  Directory? _directory;
  File? _file;
  List<StatisticsModel>? _cachedStatisticsModels;

  LocalFileStatisticsDatasource();

  @override
  Future<void> insertData(StatisticsModel model) async {
    try {
      List<StatisticsModel>? newStatisticsList;

      final statisticsList = await fetchData();

      newStatisticsList = [...statisticsList ?? [], model];

      _cachedStatisticsModels = null;

      await _file!.writeAsString(jsonEncode(newStatisticsList));
    } on Object catch (e, stack) {
      throw Exception("Exception $e StackTrace: $stack");
    }
  }

  @override
  FutureOr<List<StatisticsModel>?> fetchData() async {
    log("Fetch Data");

    _cachedStatisticsModels ??= await _fetchDataFromFile();
    return _cachedStatisticsModels;
  }

  Future<List<StatisticsModel>?> _fetchDataFromFile() async {
    try {
      if (_file == null) await [_fetchFile()].wait;

      final stringStatistics = await _file!.readAsString();
      if (stringStatistics.isEmpty) return null;
      final jsonStatistics = jsonDecode(stringStatistics) as List<dynamic>;
      final statisticsList = jsonStatistics
          .map((json) => StatisticsModel.fromJson(json))
          .toList();

      return statisticsList;
    } on Object catch (e, stack) {
      throw Exception("Exception $e StackTrace: $stack");
    }
  }

  Future<File?> _fetchFile() async {
    try {
      if (_directory == null) await [_fetchDirectory()].wait;

      _file = File("${_directory!.path}/statisticsData/statistics.md");
      await _file!.parent.create(recursive: true);
      await _file!.create(recursive: true);
      return null;
    } on Object catch (e, stack) {
      throw Exception("Exception $e StackTrace: $stack");
    }
  }

  Future<Directory?> _fetchDirectory() async {
    _directory = await getExternalStorageDirectory();
    return null;
  }
}
