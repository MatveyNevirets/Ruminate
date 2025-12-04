import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/providers/reflection_datasource_repository_provider.dart';
import 'package:ruminate/features/personal_victories/provider/victories_repository_provider.dart';
import 'package:ruminate/features/statistics/data/repository/statistics_repository_impl.dart';
import 'package:ruminate/features/statistics/domain/repository/statistics_repository.dart';
import 'package:ruminate/features/statistics/providers/local_statistics_datasource_provider.dart';

final statisticsRepositoryProvider = Provider<StatisticsRepository>(
  (ref) => StatisticsRepositoryImpl(
    localStatisticsDatasource: ref.watch(localStatisticsDatasourceProvider),
    victoriesRepository: ref.watch(victoriesRepositoryProvider),
    reflectionRepsoitory: ref.watch(reflectionRepositoryProvider),
  ),
);
