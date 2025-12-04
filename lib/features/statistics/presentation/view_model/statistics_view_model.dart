import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/features/statistics/data/models/statistics_model.dart';
import 'package:ruminate/features/statistics/domain/repository/statistics_repository.dart';
import 'package:ruminate/features/statistics/providers/statistics_repository_provider.dart';

class StatisticsViewModel
    extends StateNotifier<AsyncValue<List<StatisticsModel>?>> {
  final StatisticsRepository statisticsRepository;
  bool _isLoading = false;

  StatisticsViewModel({required this.statisticsRepository})
    : super(const AsyncValue.loading()) {
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      if (_isLoading) return;

      _isLoading = true;
      state = AsyncValue.loading();

      final statisticsList = await statisticsRepository.fetchData();
      _isLoading = false;

      state = AsyncValue.data(statisticsList);
    } on Object catch (e, stack) {
      state = AsyncValue.error(e, stack);
      throw Exception("Exception: $e StackTrace: $stack");
    }
  }

  Future<void> insertData(StatisticsModel model) async {
    try {
      await statisticsRepository.insertData(model);
    } on Object catch (e, stack) {
      state = AsyncValue.error(e, stack);
      throw Exception("Exception: $e StackTrace: $stack");
    }
  }
}

final statisticsViewModelProvider =
    StateNotifierProvider<
      StatisticsViewModel,
      AsyncValue<List<StatisticsModel>?>
    >(
      (ref) => StatisticsViewModel(
        statisticsRepository: ref.watch(statisticsRepositoryProvider),
      ),
    );
