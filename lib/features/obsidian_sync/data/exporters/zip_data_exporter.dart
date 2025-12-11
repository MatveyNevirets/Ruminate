import 'dart:developer';

import 'package:ruminate/features/obsidian_sync/data/exporters/data_exporter.dart';

class ZipDataExporter implements DataExporter {
  @override
  Future<void> export() async {
    log("Zip export");
  }
}
