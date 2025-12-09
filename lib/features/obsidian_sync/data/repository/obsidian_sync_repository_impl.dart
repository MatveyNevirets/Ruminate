import 'package:ruminate/features/obsidian_sync/data/datasources/obsidian_sync_datasource.dart';
import 'package:ruminate/features/obsidian_sync/domain/repository/obsidian_sync_repository.dart';

class ObsidianSyncRepositoryImpl implements ObsidianSyncRepository {
  late final ObsidianSyncDatasource obsidianSyncDatasource;

  @override
  void syncWithObsidian() {
    obsidianSyncDatasource.syncWithObsidian();
  }
}
