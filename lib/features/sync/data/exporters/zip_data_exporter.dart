import 'dart:developer';

import 'package:ruminate/features/sync/data/exporters/data_exporter.dart';

class ZipDataExporter implements DataExporter {
  const ZipDataExporter();
  @override
  Future<void> export() async {
    log("Zip export");
  }
}
