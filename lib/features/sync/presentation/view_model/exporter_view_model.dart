import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/features/sync/data/providers/export_service_provider.dart';
import 'package:ruminate/features/sync/data/services/export_service.dart';
import 'package:ruminate/features/sync/enums/export_format.dart';

class ExporterViewModel extends StateNotifier<String> {
  final ExporterService _exporterService;

  ExporterViewModel(this._exporterService) : super("");

  Future<void> export(ExportFormat format) async {
    try {
      await _exporterService.export(format);
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }
}

final exporterViewModelProvider =
    StateNotifierProvider<ExporterViewModel, String>(
      (ref) => ExporterViewModel(ref.watch(exporterServiceProvider)),
    );
