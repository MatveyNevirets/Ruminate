import 'dart:developer';

import 'package:ruminate/features/sync/data/exporters/data_exporter.dart';

class OneFileDataExporter implements DataExporter {
  const OneFileDataExporter();
  @override
  Future<void> export() async {
    log("One file export");
  }
}
