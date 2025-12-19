import 'package:ruminate/core/reflection/data/model/reflection_model.dart';
import 'package:ruminate/features/statistics/data/models/statistics_model.dart';

abstract class DataExporter {
  const DataExporter();
  Future<void> export({
    required List<ReflectionModel> reflections,
    required List<StatisticsModel> statistics,
  });
}
