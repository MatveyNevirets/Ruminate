import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/features/sync/enums/export_format.dart';
import 'package:ruminate/features/sync/presentation/view_model/exporter_view_model.dart';

class ObsidianSyncButton extends StatelessWidget {
  const ObsidianSyncButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final exporterVM = ref.watch(exporterViewModelProvider.notifier);
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutlinedButton(
              onPressed: () => exporterVM.export(ExportFormat.oneFile),
              child: Text("Экспорт одним .md файлом"),
            ),
            OutlinedButton(
              onPressed: () => exporterVM.export(ExportFormat.zip),
              child: Text("Экспорт в несколько заметок .zip"),
            ),
          ],
        );
      },
    );
  }
}
