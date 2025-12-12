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

class ZipDataExporter implements DataExporter {
  ZipDataExporter();

  // For write human's readable, comfort date format
  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');

  @override
  Future<void> export({
    required List<ReflectionModel> reflections,
    required List<StatisticsModel> statistics,
  }) async {
    // Creates temp directory to share .zip file at future
    final tempDir = await getTemporaryDirectory();
    // Time stamp for get unique export directory path
    final timeStamp = DateTime.now().millisecondsSinceEpoch;
    // Here we creates directory that we'll share
    final exportDir = Directory("${tempDir.path}/ruminate_export_$timeStamp");
    await exportDir.create(recursive: true);

    // Creates object to archive our data and creates the .zip file
    final archive = Archive();

    for (ReflectionModel reflection in reflections) {
      // Here we generates .md files
      // This files will be comfort readable inside the obsidian
      final reflectionArchiveFile = await _generateDailyMarkdownFile(
        tempDir,
        reflection,
      );
      // When file done
      // We adds this one inside the archive
      archive.add(reflectionArchiveFile);
    }

    // When we ends with reflections we starts generate statistics file
    // Also comfort readable inside the obsidian
    final statisticsArchiveFile = await _generateStatisticsMarkdownFile(
      statistics,
    );

    // Inserts file inside archive
    archive.addFile(statisticsArchiveFile);

    // Creates this one to pack our archive like .zip file
    final zipArchive = ZipEncoder();

    // Encodes archive to bytes
    final bytes = zipArchive.encode(archive);

    // Here we creates output stream to create .zip file
    final outputStream = OutputFileStream(
      "${tempDir.path}/ruminate_export.zip",
      bufferSize: 2048,
    );

    // Then into this stream we writes our bytes data
    outputStream.writeBytes(bytes);

    // And encoding that one
    zipArchive.encodeStream(archive, outputStream);

    // OK. Our archive ready. Then we starts share it
    // Creates ShareParams and fill it one
    final shareParams = ShareParams(
      // We want to send our borned file
      files: [XFile("${tempDir.path}/ruminate_export.zip")],
    );

    // And send it one
    await SharePlus.instance.share(shareParams);
  }

  Future<ArchiveFile> _generateStatisticsMarkdownFile(
    List<StatisticsModel> statisticModels,
  ) async {
    // To creates a beautiful string we creates StringBuffer object
    // To fill it some our data
    final StringBuffer buffer = StringBuffer();

    // Header
    buffer.writeln("# Это технический файл со всей твоей статистикой");
    buffer.writeln();
    buffer.writeln("---");
    buffer.writeln();

    // Based data
    for (StatisticsModel statistic in statisticModels) {
      // Data
      buffer.writeln(_dateFormat.format(statistic.date));
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

    // Then when we have the data
    // We encode this one to bytes
    final bytesContent = utf8.encode(buffer.toString());

    // Creates archive file
    final archiveFile = ArchiveFile(
      // Title
      "StatisticsFile.md",
      // Bytes size
      bytesContent.length,
      // Bytes data
      bytesContent,
    );

    return archiveFile;
  }

  Future<ArchiveFile> _generateDailyMarkdownFile(
    Directory tempDir,
    ReflectionModel reflection,
  ) async {
    // To creates a beautiful string we creates StringBuffer object
    // To fill it some our data
    final StringBuffer buffer = StringBuffer();

    // Fetch a beatiful, readable date
    final formattedDate = _dateFormat.format(reflection.reflectionDate!);

    // Creates file name with our date, title and milliseconds
    // To convert all reflections
    final fileName =
        "Reflections/Ruminate $formattedDate ${reflection.title} ${reflection.reflectionDate!.millisecondsSinceEpoch}.md";

    // Title
    buffer.write("# ${reflection.title} - $formattedDate");
    buffer.writeln("");
    buffer.writeln();
    buffer.writeln("---");
    buffer.writeln();
    for (ReflectionStepModel step in reflection.steps) {
      // Step title after separator
      buffer.writeln("## ${step.title}:");
      buffer.writeln();

      for (Map<String, String?> qna in step.questionsAndAnswers) {
        // If we have answer to question
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

    // Then when we have the data
    // We encode this one to bytes
    final bytesContent = utf8.encode(buffer.toString());

    // Creates and return Archive file
    return ArchiveFile(
      // File name
      fileName,
      // Bytes size
      bytesContent.length,
      // Bytes data
      bytesContent,
    );
  }
}
