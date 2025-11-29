import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ruminate/core/data/datasources/local/local_reflection_datasource.dart';
import 'package:ruminate/core/data/datasources/local/mock_local_file_reflection_datasource.dart';
import 'package:ruminate/core/data/datasources/repository/reflection_repository_impl.dart';
import 'package:ruminate/core/data/providers/local_file_datasource_provider.dart';
import 'package:ruminate/core/domain/reflection_repository.dart';
import 'package:ruminate/core/providers/reflection_datasource_repository_provider.dart';

void main() {
  late ProviderContainer container;
  late ReflectionRepository mockReflectionRepository;
  late LocalReflectionDatasource mockLocalReflectionDataSource;

  setUp(() {
    mockLocalReflectionDataSource = MockLocalFileReflectionDataSource();

    mockReflectionRepository = ReflectionRepositoryImpl(localReflectionDatasource: mockLocalReflectionDataSource);

    container = ProviderContainer(
      overrides: [
        localFileDataSourceProvider.overrideWithValue(mockLocalReflectionDataSource),
        reflectionRepositoryProvider.overrideWithValue(mockReflectionRepository),
      ],
    );
    addTearDown(container.dispose);
  });

  group('Testing completed reflections feature', () {
    test('Try to fetch reflections', () async {
      final reflections = await container.read(reflectionRepositoryProvider).fetchAllReflections();

      expect(reflections, null);
    });
  });
}
