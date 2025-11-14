import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/data/datasources/local/local_file_reflection_datasource.dart';
import 'package:ruminate/core/data/datasources/local/local_reflection_datasource.dart';
import 'package:ruminate/core/providers/path_service_provider.dart';

final localFileDataSourceProvider = Provider<LocalReflectionDatasource>(
  (ref) => LocalFileReflectionDataSource(pathService: ref.read(pathServiceProvider)),
);
