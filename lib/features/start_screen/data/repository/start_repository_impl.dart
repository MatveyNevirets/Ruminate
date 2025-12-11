import 'package:ruminate/features/start_screen/data/datasource/start_datasource.dart';
import 'package:ruminate/features/start_screen/domain/repository/start_repository.dart';

class StartRepositoryImpl implements StartRepository {
  late final StartDatasource startDatasource;

  StartRepositoryImpl({required this.startDatasource});

  @override
  Future<List<bool>> fetchStartValues() async {
    return await startDatasource.fetchStartValues();
  }

  @override
  Future<void> setFirstValue(bool value) async {
    await startDatasource.setFirstEnter(value);
  }

  @override
  Future<void> setHavePassword(bool value) async {
    await startDatasource.setHavePassword(value);
  }
}
