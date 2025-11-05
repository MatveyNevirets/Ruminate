import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ruminate/features/reflection/data/model/reflection_model.dart';

class LocalFileDataSource {
  Directory? _directory;
  LocalFileDataSource() {
    _initStorage();
  }

  Future<void> insertReflectionIntoDirectory(ReflectionModel reflection) async {
    //Recieves a reflection map from model's method
    final reflectionMap = reflection.toMap();

    try {
      //Recieves the file we create and fill out
      final file = File(
        "${_directory?.path}/data/reflection_${reflection.title.replaceAll(" ", "")}${DateTime.now().millisecondsSinceEpoch}.md",
      );

      await file.parent.create(recursive: true);

      //Write the reflection as json
      await file.writeAsString(jsonEncode(reflectionMap));
      log("Success write!");
    } on Exception catch (e, stack) {
      throw Exception(
        "Exception at local reflection datasource. Method: insertReflectionIntoDirectory. Exception: $e StackTrace: $stack",
      );
    }
  }

  Future<List<ReflectionModel>> readAllReflectionsFromDirectory() async {
    try {
      //In first we attempts fetch the directory of our reflections
      final directoryFile = await _fetchDirectory();

      //Then attempts fetch our files like list
      final List<FileSystemEntity> files = await directoryFile!.list().toList();

      //Recieves reflection files
      final reflectionFiles = files.whereType<File>().where((file) {
        final fileTitle = file.path.split(Platform.pathSeparator).last;
        return fileTitle.startsWith("reflection_") && fileTitle.endsWith(".md");
      }).toList();

      List<ReflectionModel> reflections = [];

      //Converts strings to a ReflectionModel, then returns reflections as a list
      for (File file in reflectionFiles) {
        final reflectionString = await file.readAsString();
        final reflection = ReflectionModel.fromJson(reflectionString);
        reflections.add(reflection);
        log(reflection.title);
      }

      return reflections;
    } on Exception catch (e, stack) {
      throw Exception(
        "Exception at local reflection datasource. Method: readAllReflectionsFromDirectory. Exception: $e StackTrace: $stack",
      );
    }
  }

  Future<void> _initStorage() async {
    _directory = await getExternalStorageDirectory();
  }

  Future<Directory?> _fetchDirectory() async {
    final directoryFile = Directory("${_directory?.path}/data/");
    final directoyExists = await directoryFile.exists();

    while (!directoyExists) {
      await Future.delayed(Duration(seconds: 1));
    }
    log("Exists ${directoryFile.toString()}");
    return directoryFile;
  }
}


