// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ruminate/core/data/datasources/local/local_file_reflection_datasource.dart';
import 'package:ruminate/core/data/datasources/local/local_reflection_datasource.dart';
import 'package:ruminate/core/data/model/reflection_model.dart';
import 'package:ruminate/core/data/providers/local_file_datasource_provider.dart';
import 'package:ruminate/core/enums/reflect_type_enum.dart';
import 'package:ruminate/core/services/path_service.dart';

class MockPathService extends Mock implements PathService {}

class MockDirectory extends Mock implements Directory {
  final Map<String, String> files = {};
  final List<String> createdDirectories = [];
}

class MockFile extends Mock implements File {
  final MockDirectory parentDirectory;
  @override
  final String path;
  String content;
  MockFile({required this.parentDirectory, required this.path, this.content = ''});

  @override
  Future<File> writeAsString(
    String contents, {
    FileMode mode = FileMode.write,
    Encoding encoding = utf8,
    bool flush = false,
  }) async {
    content = contents;
    parentDirectory.files[path] = contents;
    return this;
  }

  @override
  Future<String> readAsString({Encoding encoding = utf8}) async {
    return parentDirectory.files[path] ?? '';
  }
}

ReflectionModel createTestReflection({String title = 'Test Reflection'}) {
  return ReflectionModel(title: title, steps: [], description: '', type: ReflectType.dailyIndepth);
}

void main() {
  late LocalReflectionDatasource localReflectionDatasource;
  late MockDirectory mockDirectory;
  late MockPathService mockPathService;

  setUp(() async {
    mockPathService = MockPathService();
    mockDirectory = MockDirectory();

    when(() => mockPathService.getExternalStorageDirectory()).thenAnswer((_) async => mockDirectory);
    when(() => mockDirectory.path).thenReturn("/test/directory/");

    localReflectionDatasource = LocalFileReflectionDataSource(pathService: mockPathService);
  });

  group('Testing LocalFileReflectionDatasource', () {
    test('Testing database initialization', () async {
      verify(() => mockPathService.getExternalStorageDirectory()).called(1);

      expect(localFileDataSourceProvider, isNotNull);
    });
    test('Testing insert reflection method', () async {
     await localReflectionDatasource.insertReflection(createTestReflection());
    });
  });
}
