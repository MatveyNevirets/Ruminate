import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ruminate/features/reflection/data/model/reflection_model.dart';

class LocalReflectionDataSource {
  Directory? directory;
  LocalReflectionDataSource() {
    _initStorage();
  }

  Future<void> insertReflectionIntoDirectory(ReflectionModel reflection) async {
    final reflectionMap = reflection.toMap();

    final file = File(
      "${directory?.path}/data/reflection_${reflection.title.replaceAll(" ", "")}${DateTime.now().millisecondsSinceEpoch}.md",
    );

    await file.parent.create(recursive: true);

    await file.writeAsString(jsonEncode(reflectionMap));
    final str = await file.readAsString();
    log("Success inserted! Path: ${file.path} Data: $str");
  }

  Future<List<ReflectionModel>> readAllReflectionsFromDirectory() async {
    final directoryFile = Directory("${directory?.path}/data/");

    final List<FileSystemEntity> files = await directoryFile.list().toList();

    final reflectionFiles = files.whereType<File>().where((file) {
      final fileTitle = file.path.split(Platform.pathSeparator).last;
      return fileTitle.startsWith("reflection_") && fileTitle.endsWith(".md");
    }).toList();

    List<ReflectionModel> reflections = [];

    for (File file in reflectionFiles) {
      final reflectionString = await file.readAsString();
      final reflection = ReflectionModel.fromJson(reflectionString);
      reflections.add(reflection);
      log(reflection.title);
    }

    return reflections;
  }

  Future<void> _initStorage() async {
    directory = await getExternalStorageDirectory();
  }
}

final localStorage = Provider((ref) => LocalReflectionDataSource());
