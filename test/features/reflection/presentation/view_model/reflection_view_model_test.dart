import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ruminate/core/data/datasources/local/local_file_reflection_datasource.dart';
import 'package:ruminate/core/data/model/reflection_model.dart';
import 'package:ruminate/core/data/model/reflection_step_model.dart';
import 'package:ruminate/core/data/providers/local_file_datasource_provider.dart';
import 'package:ruminate/core/domain/reflection_repository.dart';
import 'package:ruminate/core/enums/reflect_type_enum.dart';
import 'package:ruminate/core/providers/reflection_datasource_repository_provider.dart';
import 'package:ruminate/features/reflection/domain/providers/daily_indepth_reflection_provider.dart';
import 'package:ruminate/features/reflection/domain/providers/daily_superficial_reflection_provider.dart';
import 'package:ruminate/features/reflection/domain/providers/monthly_reflection_provider.dart';
import 'package:ruminate/features/reflection/domain/providers/weekly_reflection_provider.dart';
import 'package:ruminate/features/reflection/presentation/providers/reflection_view_model_provider.dart';

class MockFileDataSource extends Mock implements LocalFileReflectionDataSource {}

class MockReflectionModel extends Mock implements ReflectionModel {}

class MockBuildContext extends Mock implements BuildContext {}

class MockReflectionRepository extends Mock implements ReflectionRepository {}

void main() {
  late ProviderContainer container;
  late MockFileDataSource mockFileDataSource;
  late MockReflectionModel mockDailySuperficialReflection,
      mockDailyIndepthReflection,
      mockWeeklyReflection,
      mockMonthlyReflection;
  late MockReflectionRepository mockReflectionRepository;
  late MockBuildContext mockContext;

  setUpAll(() {
    registerFallbackValue(
      ReflectionModel(
        title: "title",
        description: "description",
        reflectionDate: DateTime.now(),
        type: ReflectType.testUnknown,
        steps: [],
      ),
    );
  });

  setUp(() {
    mockFileDataSource = MockFileDataSource();
    mockDailySuperficialReflection = MockReflectionModel();
    mockDailyIndepthReflection = MockReflectionModel();
    mockWeeklyReflection = MockReflectionModel();
    mockMonthlyReflection = MockReflectionModel();
    mockContext = MockBuildContext();
    mockReflectionRepository = MockReflectionRepository();

    when(() => mockDailySuperficialReflection.steps).thenReturn([]);
    when(() => mockDailyIndepthReflection.steps).thenReturn([]);
    when(() => mockWeeklyReflection.steps).thenReturn([]);
    when(() => mockMonthlyReflection.steps).thenReturn([]);
    when(() => mockReflectionRepository.insertReflection(any())).thenAnswer((_) => Future.value());

    container = ProviderContainer(
      overrides: [
        localFileDataSourceProvider.overrideWithValue(mockFileDataSource),
        dailySuperficialReflectionProvider.overrideWithValue(mockDailySuperficialReflection),
        dailyIndepthReflectionProvider.overrideWithValue(mockDailyIndepthReflection),
        weeklyReflectionProvider.overrideWithValue(mockWeeklyReflection),
        monthlyReflectionProvider.overrideWithValue(mockMonthlyReflection),
        reflectionRepositoryProvider.overrideWithValue(mockReflectionRepository),
      ],
    );
    addTearDown(container.dispose);
  });

  group('Reflection ViewModel', () {
    group('Testing steps navigation', () {
      test('Testing insertStep method', () {
        // Arrange
        final steps = [
          ReflectionStepModel(title: '1', description: 'description', questionsAndAnswers: []),
          ReflectionStepModel(title: '2', description: 'description', questionsAndAnswers: []),
          ReflectionStepModel(title: '3', description: 'description', questionsAndAnswers: []),
        ];
        final viewModel = container.read(reflectionVM.notifier);

        // Act
        for (ReflectionStepModel step in steps) {
          viewModel.insertStep(step);
        }

        // Assert
        expect(viewModel.firstStep, steps[0]);
        expect(viewModel.lastStep, steps[2]);
      });

      test('Testing nextStep method', () {
        // Arrange
        final steps = [
          ReflectionStepModel(
            title: '1',
            description: 'description',
            questionsAndAnswers: [
              {'Question 1?': null},
            ],
          ),
          ReflectionStepModel(
            title: '2',
            description: 'description',
            questionsAndAnswers: [
              {'Question 1?': null},
            ],
          ),
        ];

        final viewModel = container.read(reflectionVM.notifier);

        final testModel = ReflectionModel(
          title: 'Test',
          steps: steps,
          type: ReflectType.dailySuperficital,
          reflectionDate: DateTime.now(),
          description: '',
        );

        when(() => mockDailySuperficialReflection.steps).thenReturn(steps);
        when(() => mockDailySuperficialReflection.copyWith(steps: any(named: 'steps'))).thenReturn(testModel);

        // Act
        viewModel.setType(ReflectType.dailySuperficital);
        viewModel.nextStep(['Answer'], mockContext);

        // Assert
        expect(viewModel.state, viewModel.currentReflection!.steps[1]);
      });

      test('Testing prevStep method', () {
        // Arrange
        final steps = [
          ReflectionStepModel(
            title: '1',
            description: 'description',
            questionsAndAnswers: [
              {'Question 1?': null},
            ],
          ),
          ReflectionStepModel(
            title: '2',
            description: 'description',
            questionsAndAnswers: [
              {'Question 1?': null},
            ],
          ),
        ];

        final viewModel = container.read(reflectionVM.notifier);

        final testModel = ReflectionModel(
          title: 'Test',
          steps: steps,
          reflectionDate: DateTime.now(),
          type: ReflectType.dailySuperficital,
          description: '',
        );

        when(() => mockDailySuperficialReflection.steps).thenReturn(steps);
        when(() => mockDailySuperficialReflection.copyWith(steps: any(named: 'steps'))).thenReturn(testModel);

        // Act
        viewModel.setType(ReflectType.dailySuperficital);
        viewModel.state = viewModel.lastStep;
        viewModel.prevStep();

        // Assert
        expect(viewModel.state, viewModel.currentReflection!.steps[0]);
      });
    });

    group('Testing setType() method', () {
      test('Testing dailySuperficital ReflectType', () {
        //Arrange
        final viewModel = container.read(reflectionVM.notifier);

        //Act
        viewModel.setType(ReflectType.dailySuperficital);

        //Assert
        expect(viewModel.currentReflection, mockDailySuperficialReflection);
      });

      test('Testing dailyIndepth ReflectType', () {
        //Arrange
        final viewModel = container.read(reflectionVM.notifier);

        //Act
        viewModel.setType(ReflectType.dailyIndepth);

        //Assert
        expect(viewModel.currentReflection, mockDailyIndepthReflection);
      });
    });

    test('Testing weekly ReflectType', () {
      //Arrange
      final viewModel = container.read(reflectionVM.notifier);

      //Act
      viewModel.setType(ReflectType.weekly);

      //Assert
      expect(viewModel.currentReflection, mockWeeklyReflection);
    });

    test('Testing monthly ReflectType', () {
      //Arrange
      final viewModel = container.read(reflectionVM.notifier);

      //Act
      viewModel.setType(ReflectType.monthly);

      //Assert
      expect(viewModel.currentReflection, mockMonthlyReflection);
    });

    test('Testing unknown ReflectType', () {
      //Arrange
      final viewModel = container.read(reflectionVM.notifier);

      //Act & Assert
      expect(() => viewModel.setType(ReflectType.testUnknown), throwsException);
    });
  });

  test('Testing complete method', () {
    // Arrange
    final steps = [
      ReflectionStepModel(
        title: '1',
        description: 'description',
        questionsAndAnswers: [
          {'Q1': null},
        ],
      ),
    ];

    final testModel = ReflectionModel(
      title: "title",
      description: "",
      type: ReflectType.dailySuperficital,
      reflectionDate: DateTime.now(),
      steps: steps,
    );
    final viewModel = container.read(reflectionVM.notifier);

    when(() => mockDailySuperficialReflection.steps).thenReturn(steps);
    when(() => mockDailySuperficialReflection.copyWith(steps: any(named: "steps"))).thenReturn(testModel);

    // Act
    viewModel.setType(ReflectType.dailySuperficital);

    expect(viewModel.currentReflection, isNotNull);

    mockReflectionRepository.insertReflection(viewModel.currentReflection!);

    // Assert
    verify(() => mockReflectionRepository.insertReflection(any())).called(1);
  });
}
