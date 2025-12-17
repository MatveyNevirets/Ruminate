import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/features/start/data/repository/start_repository_impl.dart';
import 'package:ruminate/features/start/domain/repository/start_repository.dart';
import 'package:ruminate/features/start/providers/start_datasource_provider.dart';

final startRepositoryProvider = Provider<StartRepository>(
  (ref) =>
      StartRepositoryImpl(startDatasource: ref.watch(startDatasourceProvider)),
);
