import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ruminate/core/data/model/reflection_model.dart';
import 'package:ruminate/core/data/model/reflection_step_model.dart';
import 'package:ruminate/features/statistics/data/models/statistics_model.dart';
import 'package:ruminate/features/sync/data/exporters/data_exporter.dart';
import 'package:share_plus/share_plus.dart';

class OneFileDataExporter implements DataExporter {
  OneFileDataExporter();

  final DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  @override
  Future<void> export({
    required List<ReflectionModel> reflections,
    required List<StatisticsModel> statistics,
  }) async {
    // Creates temp directory to share .md file at future
    final tempDir = await getTemporaryDirectory();
    // Time stamp for get unique export directory path
    final timeStamp = DateTime.now().millisecondsSinceEpoch;
    final exportDir = Directory("${tempDir.path}/ruminate_export_$timeStamp");
    await exportDir.create(recursive: true);

    // Here we generate a file
    // To share
    final generatedString = await _generateOneFileMardownFile(
      reflections,
      statistics,
    );

    // Fetch a beatiful, readable date
    final formattedDate = dateFormat.format(DateTime.now());

    // Creates file name with our date, title and milliseconds
    // To convert all reflections
    final fileName = "Ruminate_$formattedDate.md";

    // Here we creates new file
    final fileToShare = File("${tempDir.path}/$fileName");
    await fileToShare.create(recursive: true);

    String data = "";

    // Checking file's data
    data = await fileToShare.readAsString();

    // While data is empty, we tring to write our
    // Generated data
    while (data.isEmpty) {
      fileToShare.writeAsString(generatedString);
    }

    // Then creates params
    final shareParams = ShareParams(files: [XFile(fileToShare.path)]);

    // And share
    await SharePlus.instance.share(shareParams);
  }

  Future<String> _generateOneFileMardownFile(
    List<ReflectionModel> reflections,
    List<StatisticsModel> statistics,
  ) async {
    // To creates a beautiful string we creates StringBuffer object
    // To fill it some our data
    final StringBuffer buffer = StringBuffer();

    // Title
    buffer.write("# Все твои рефлексии:");
    buffer.writeln("");
    buffer.writeln();
    buffer.writeln("---");
    buffer.writeln();

    for (ReflectionModel reflection in reflections) {
      buffer.writeln(
        "## ${reflection.title} Дата: ${dateFormat.format(reflection.reflectionDate!)}",
      );
      buffer.writeln();
      for (ReflectionStepModel step in reflection.steps) {
        // Step title after separator
        buffer.writeln("## ${step.title}:");
        buffer.writeln();

        for (Map<String, String?> qna in step.questionsAndAnswers) {
          // If we have answer to question
          if (qna.values.first != null) {
            buffer.writeln("*Вопрос:* ${qna.keys.first}");
            buffer.writeln("*Твой ответ:* ${qna.values.first}");
            buffer.writeln();
          }
        }
        buffer.writeln();
        buffer.writeln("---");
        buffer.writeln();
      }
    }

    // The statistic's data
    buffer.writeln("# Данные статистики:");
    // Separator
    buffer.writeln();
    buffer.writeln("---");
    buffer.writeln();
    for (StatisticsModel statistic in statistics) {
      // Data
      buffer.writeln(dateFormat.format(statistic.date));
      // Total reflections
      buffer.writeln("Всего рефлексий: ${statistic.totalReflections}");
      // Total victories
      buffer.writeln("Всего побед: ${statistic.totalVictories}");
      // Energy generators
      if (statistic.energyGenerators != null &&
          statistic.energyGenerators!.isNotEmpty) {
        buffer.writeln(
          "Добавлен в общий список генератор энергии: ${statistic.energyGenerators}",
        );
      }
      // Energy killers
      if (statistic.energyKillers != null &&
          statistic.energyKillers!.isNotEmpty) {
        buffer.writeln(
          "Добавлен в общий список пожиратель энергии: ${statistic.energyKillers}",
        );
      }
      // Important to work
      if (statistic.importantToWork != null &&
          statistic.importantToWork!.isNotEmpty) {
        buffer.writeln(
          "Добавлено действие, над которым важно было бы поработать: ${statistic.importantToWork}",
        );
      }
      // Fears
      if (statistic.fears != null && statistic.fears!.isNotEmpty) {
        buffer.writeln("Старх добавлен в общий список: ${statistic.fears}");
      }
      // Separators
      buffer.writeln();
      buffer.writeln();
    }

    return buffer.toString();
  }
}
