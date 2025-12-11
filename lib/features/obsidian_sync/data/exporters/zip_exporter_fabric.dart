import 'package:ruminate/features/obsidian_sync/data/exporters/data_exporter.dart';
import 'package:ruminate/features/obsidian_sync/data/exporters/exporter_fabric.dart';
import 'package:ruminate/features/obsidian_sync/data/exporters/zip_data_exporter.dart';

class ZipExporterFabric implements ExporterFabric {
  @override
  DataExporter createDataExporter() => ZipDataExporter();

  @override
  String get name => "Zip exporter fabric";
}
