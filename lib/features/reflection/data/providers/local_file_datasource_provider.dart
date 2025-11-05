import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/features/reflection/data/datasources/local_reflection_datasource/local_reflection_datasource.dart';

final localFileDataSourceProvider = Provider((ref) => LocalFileDataSource());
