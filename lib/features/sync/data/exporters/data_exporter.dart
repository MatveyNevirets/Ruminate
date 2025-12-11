import 'package:ruminate/core/data/model/reflection_model.dart';
import 'package:ruminate/features/statistics/data/models/statistics_model.dart';

abstract class DataExporter {
  const DataExporter();
  Future<void> export({
    required List<ReflectionModel> reflections,
    required List<String> victories,
    required List<StatisticsModel> statistics,
  });
}
