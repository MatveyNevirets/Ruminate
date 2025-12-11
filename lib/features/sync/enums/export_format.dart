import 'package:ruminate/features/sync/data/exporters/data_exporter.dart';
import 'package:ruminate/features/sync/data/exporters/one_file_data_exporter.dart';
import 'package:ruminate/features/sync/data/exporters/zip_data_exporter.dart';

enum ExportFormat {
  zip(name: "ZIP архив"),
  oneFile(name: "Один файл");

  const ExportFormat({required this.name});

  final String name;

  DataExporter createExporter() {
    return switch (this) {
      ExportFormat.zip => ZipDataExporter(),
      ExportFormat.oneFile => OneFileDataExporter(),
    };
  }
}
