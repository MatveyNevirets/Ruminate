import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ruminate/features/personal_victories/domain/repository/victories_repository.dart';
import 'package:ruminate/features/personal_victories/presentation/viewmodel/personal_victories_view_model.dart';
import 'package:ruminate/features/personal_victories/provider/victories_repository_provider.dart';

class MockVictoriesRepository extends Mock implements VictoriesRepository {}

void main() {
  late ProviderContainer container;
  late MockVictoriesRepository mockVictoriesRepository;
  late PersonalVictoriesViewModel personalVictoriesViewModel;

  List<String> mockVictories = ["v1", "v2", "v3"];

  setUpAll(() {
    registerFallbackValue(List<String>);
  });

  setUp(() {
    mockVictoriesRepository = MockVictoriesRepository();

    when(() => mockVictoriesRepository.insertVictories(any())).thenAnswer((_) => Future.value());
    when(() => mockVictoriesRepository.fetchVictories()).thenAnswer((_) => Future.value(mockVictories));

    personalVictoriesViewModel = PersonalVictoriesViewModel(mockVictoriesRepository);

    container = ProviderContainer(overrides: [victoriesRepositoryProvider.overrideWithValue(mockVictoriesRepository)]);
  });

  tearDownAll(() {
    container.dispose();
  });

  group('Testing personal victories', () {
    test('Testing insertVictories method', () async {
      final List<String> fakeVictories = ["v1", "v2"];

      await personalVictoriesViewModel.insertVictories(fakeVictories);

      verify(() => mockVictoriesRepository.insertVictories(any())).called(1);
    });
  });
}
