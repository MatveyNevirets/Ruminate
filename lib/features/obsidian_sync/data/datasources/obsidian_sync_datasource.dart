import 'package:ruminate/features/obsidian_sync/data/exporters/exporter_fabric.dart';
import 'package:ruminate/features/obsidian_sync/enums/export_format.dart';

abstract class ObsidianSyncDatasource {
  List<Map<String, ExporterFabric>> _registerFabrics();

  Future<void> export(ExportFormat format);
}