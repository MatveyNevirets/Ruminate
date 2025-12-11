import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/providers/reflection_datasource_repository_provider.dart';
import 'package:ruminate/features/personal_victories/provider/victories_repository_provider.dart';
import 'package:ruminate/features/statistics/providers/statistics_repository_provider.dart';
import 'package:ruminate/features/sync/data/services/export_service.dart';

final exporterServiceProvider = Provider<ExporterService>(
  (ref) => ExporterService(
    reflectionRepository: ref.watch(reflectionRepositoryProvider),
    victoriesRepository: ref.watch(victoriesRepositoryProvider),
    statisticsRepository: ref.watch(statisticsRepositoryProvider),
  ),
);
