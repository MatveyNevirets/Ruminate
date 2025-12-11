import 'dart:developer';

import 'package:ruminate/core/data/model/reflection_model.dart';
import 'package:ruminate/features/statistics/data/models/statistics_model.dart';
import 'package:ruminate/features/sync/data/exporters/data_exporter.dart';

class ZipDataExporter implements DataExporter {
  const ZipDataExporter();

  @override
  Future<void> export({
    required List<ReflectionModel> reflections,
    required List<String> victories,
    required List<StatisticsModel> statistics,
  }) async {
    log(reflections.length.toString());
    log(victories.length.toString());
    log(statistics.length.toString());
  }
}
