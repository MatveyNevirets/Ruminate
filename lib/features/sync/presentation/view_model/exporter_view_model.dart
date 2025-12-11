import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/features/sync/data/services/export_service.dart';
import 'package:ruminate/features/sync/enums/export_format.dart';

class ExporterViewModel extends StateNotifier<String> {
  final ExporterService _exporterService;

  ExporterViewModel(this._exporterService) : super("");

  Future<void> export(ExportFormat format) async {
    await _exporterService.export(format);
  }
}

final exporterViewModelProvider =
    StateNotifierProvider<ExporterViewModel, String>(
      (ref) => ExporterViewModel(ref.watch(exporterServiceProvider)),
    );
