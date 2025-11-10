import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ruminate/core/data/datasources/local_reflection_datasource/local_reflection_datasource.dart';
import 'package:ruminate/core/data/model/reflection_model.dart';
import 'package:ruminate/core/data/providers/local_file_datasource_provider.dart';
import 'package:ruminate/core/enums/reflect_type_enum.dart';
import 'package:ruminate/features/reflection/domain/providers/daily_superficial_reflection_provider.dart';
import 'package:ruminate/features/reflection/presentation/providers/reflection_view_model_provider.dart';

class MockFileDataSource extends Mock implements LocalFileDataSource {}

class MockReflectionModel extends Mock implements ReflectionModel {}

void main() {
  late ProviderContainer container;
  late MockFileDataSource mockFileDataSource;
  late MockReflectionModel mockDailySuperficialReflection;

  setUp(() {
    mockFileDataSource = MockFileDataSource();
    mockDailySuperficialReflection = MockReflectionModel();

    when(() => mockDailySuperficialReflection.steps).thenReturn([]);

    container = ProviderContainer(
      overrides: [
        localFileDataSourceProvider.overrideWithValue(mockFileDataSource),
        dailySuperficialReflectionProvider.overrideWithValue(mockDailySuperficialReflection),
      ],
    );
    addTearDown(container.dispose);
  });

  group('Reflection ViewModel', () {
    test('Test setType() method', () {
      //Arrange
      final viewModel = container.read(reflectionVM.notifier);

      //Act
      viewModel.setType(ReflectType.dailySuperficital);

      //Assert
      expect(viewModel.currentReflection, mockDailySuperficialReflection);
    });
  });
}
