import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/domain/reflection_repository.dart';
import 'package:ruminate/core/providers/reflection_datasource_repository_provider.dart';
import 'package:ruminate/features/sync/enums/export_format.dart';

class ExporterService {
  final ReflectionRepository reflectionRepository;

  ExporterService({required this.reflectionRepository});

  Future<String> export(ExportFormat format) async {
    final exporter = format.createExporter();

    await exporter.export();

    return "";
  }
}

final exporterServiceProvider = Provider<ExporterService>(
  (ref) => ExporterService(
    reflectionRepository: ref.watch(reflectionRepositoryProvider),
  ),
);
