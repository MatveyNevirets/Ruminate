
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ruminate/application/app_runner/app_env.dart';
import 'package:ruminate/application/provider/app_env_provider.dart';
import 'package:ruminate/features/statistics/data/models/statistics_model.dart';
import 'package:ruminate/features/statistics/presentation/view_model/statistics_view_model.dart';

void main() {
  late final ProviderContainer container;

  final mockModel = StatisticsModel(
    date: DateTime.now(),
    totalReflections: 0,
    totalVictories: 0,
    energyGenerators: "energyGenerators",
    energyKillers: "energyKillers",
    importantToWork: "importantToWork",
    fears: "fears",
  );

  setUp(() {
    container = ProviderContainer(
      overrides: [appEnvProvider.overrideWithValue(AppEnv.test)],
    );
  });

  setUpAll(() {
    registerFallbackValue(mockModel);
  });

  tearDownAll(() {
    container.dispose();
  });

  test('Testing statistic feature initial state is true', () {
    final state = container.read(statisticsViewModelProvider);

    expect(state.isLoading, isTrue);
  });

  test('Testing statistics fetch method', () async {
    final statisticsVM = container.read(statisticsViewModelProvider.notifier);

    await statisticsVM.fetchData();
    final state = container.read(statisticsViewModelProvider);

    expect(state.isLoading, isFalse);
    expect(state.hasError, isFalse);
    expect(state.value, isNull);
  });

  test('Testing statistics insert method', () async {
    final statisticsVM = container.read(statisticsViewModelProvider.notifier);

    await statisticsVM.insertData(mockModel);

    await statisticsVM.fetchData();

    final state = container.read(statisticsViewModelProvider);

    expect(state.isLoading, isFalse);
    expect(state.hasError, isFalse);
    expect(state.value, isNotNull);
  });
}
