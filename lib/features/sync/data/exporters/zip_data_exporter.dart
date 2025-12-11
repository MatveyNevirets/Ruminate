import 'dart:developer';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ruminate/core/data/model/reflection_model.dart';
import 'package:ruminate/core/data/model/reflection_step_model.dart';
import 'package:ruminate/features/statistics/data/models/statistics_model.dart';
import 'package:ruminate/features/sync/data/exporters/data_exporter.dart';

class ZipDataExporter implements DataExporter {
  ZipDataExporter();

  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');
  final DateFormat _timeFormat = DateFormat('HH:mm');
  @override
  Future<void> export({
    required List<ReflectionModel> reflections,
    required List<StatisticsModel> statistics,
  }) async {
    final tempDir = await getTemporaryDirectory();
    final timeStamp = DateTime.now().millisecondsSinceEpoch;
    final exportDir = Directory("${tempDir.path}/ruminate_export_$timeStamp");
    await exportDir.create(recursive: true);

    _generateDailyMarkdownFile(tempDir, reflections[0]);

    final archive = Archive();

    int addedFiles = 0;
  }

  Future<File> _generateDailyMarkdownFile(
    Directory tempDir,
    ReflectionModel reflection,
  ) async {
    final StringBuffer buffer = StringBuffer();
    final formattedDate = _dateFormat.format(reflection.reflectionDate!);
    final newFile = File(
      "${tempDir.path}/Ruminate $formattedDate} ${reflection.title} ${reflection.reflectionDate!.millisecondsSinceEpoch}.md",
    );
    newFile.create(recursive: true);

    buffer.write("# ${reflection.title} - $formattedDate");
    buffer.writeln("");
    buffer.writeln();
    buffer.writeln("---");
    buffer.writeln();
    for (ReflectionStepModel step in reflection.steps) {
      buffer.writeln("## ${step.title}:");
      buffer.writeln();

      for (Map<String, String?> qna in step.questionsAndAnswers) {
        if (qna.values.first != null) {
          buffer.writeln("Вопрос: ${qna.keys.first}");
          buffer.writeln("Твой ответ: ${qna.values.first}");
          buffer.writeln();
        }
      }
      buffer.writeln();
      buffer.writeln("---");
      buffer.writeln();
    }

    log(buffer.toString());

    await newFile.writeAsString(buffer.toString());
    log(newFile.readAsString().toString());

    return newFile;
  }
}
