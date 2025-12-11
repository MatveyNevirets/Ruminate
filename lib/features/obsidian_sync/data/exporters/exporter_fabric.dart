import 'package:ruminate/features/obsidian_sync/data/exporters/data_exporter.dart';

abstract class ExporterFabric {
  DataExporter createDataExporter();

  String get name;
}
