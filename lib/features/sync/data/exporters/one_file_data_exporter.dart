import 'dart:developer';

import 'package:ruminate/core/data/model/reflection_model.dart';
import 'package:ruminate/features/statistics/data/models/statistics_model.dart';
import 'package:ruminate/features/sync/data/exporters/data_exporter.dart';

class OneFileDataExporter implements DataExporter {
  const OneFileDataExporter();

  @override
  Future<void> export({required List<ReflectionModel> reflections, required List<String> victories, required List<StatisticsModel> statistics}) async {
      log("One file export");
  }

}
