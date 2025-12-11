import 'package:ruminate/core/domain/reflection_repository.dart';
import 'package:ruminate/features/personal_victories/domain/repository/victories_repository.dart';
import 'package:ruminate/features/statistics/domain/repository/statistics_repository.dart';
import 'package:ruminate/features/sync/enums/export_format.dart';

class ExporterService {
  final ReflectionRepository reflectionRepository;
  final VictoriesRepository victoriesRepository;
  final StatisticsRepository statisticsRepository;

  ExporterService({
    required this.reflectionRepository,
    required this.victoriesRepository,
    required this.statisticsRepository,
  });

  Future<String> export(ExportFormat format) async {
    try {
      final exporter = format.createExporter();

      final reflections = await reflectionRepository.fetchAllReflections();
      final victories = await victoriesRepository.fetchVictories();
      final statistics = await statisticsRepository.fetchData();

      await exporter.export(
        reflections: reflections ?? [],
        statistics: statistics ?? [],
        victories: victories ?? [],
      );

      return "";
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }
}
