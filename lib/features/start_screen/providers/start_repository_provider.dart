import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/features/start_screen/data/repository/start_repository_impl.dart';
import 'package:ruminate/features/start_screen/domain/repository/start_repository.dart';
import 'package:ruminate/features/start_screen/providers/start_datasource_provider.dart';

final startRepositoryProvider = Provider<StartRepository>(
  (ref) =>
      StartRepositoryImpl(startDatasource: ref.watch(startDatasourceProvider)),
);
