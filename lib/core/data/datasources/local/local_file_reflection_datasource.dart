import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:ruminate/core/data/datasources/local/local_reflection_datasource.dart';
import 'package:ruminate/core/data/model/reflection_model.dart';
import 'package:ruminate/core/services/path_service.dart';

class LocalFileReflectionDataSource implements LocalReflectionDatasource {
  Directory? _directory;
  final PathService pathService;
  List<ReflectionModel>? _cachedReflections;

  LocalFileReflectionDataSource({required this.pathService}) {
    initDatasource();
  }

  @override
  FutureOr<List<ReflectionModel>> fetchAllReflections() async {
    log("fetchAllReflections called");
    if (_cachedReflections == null) {
      final reflections = await _fetchAllReflectionsFromFile();
      _cachedReflections = reflections;
    }
    log("Fetched reflections count: ${_cachedReflections?.length}");
    return _cachedReflections!;
  }

  @override
  Future<void> insertReflection(ReflectionModel reflection) async {
    //Recieves a reflection map from model's method
    final reflectionMap = reflection.toMap();

    try {
      //Check storage initialized
      await initDatasource();

      //Recieves the file we create and fill out
      final file = File(
        "${_directory?.path}/reflectionData/reflection_${reflection.title.replaceAll(" ", "")}${DateTime.now().millisecondsSinceEpoch}.md",
      );

      await file.parent.create(recursive: true);

      //Write the reflection as json
      await file.writeAsString(jsonEncode(reflectionMap));
      log("Success wrote!");
    } on Exception catch (e, stack) {
      throw Exception(
        "Exception at local reflection datasource. Method: insertReflectionIntoDirectory. Exception: $e StackTrace: $stack",
      );
    }
  }

  Future<List<ReflectionModel>> _fetchAllReflectionsFromFile() async {
    try {
      //In first we attempts fetch the directory of our reflections
      final directoryFile = await _fetchDirectory();

      log("Directory path: ${directoryFile?.path}");

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
      }

      return reflections;
    } on Exception catch (e, stack) {
      throw Exception(
        "Exception at local reflection datasource. Method: readAllReflectionsFromDirectory. Exception: $e StackTrace: $stack",
      );
    }
  }

  Future<Directory?> _fetchDirectory() async {
    await initDatasource();

    final directoryFile = Directory("${_directory?.path}/reflectionData/");
    await directoryFile.create();

    return directoryFile;
  }

  @override
  Future<void> initDatasource() async {
    //If the storage is not initialized we will do this
    //If it is initialized, we'll simply return
    while (_directory == null) {
      _directory = await getExternalStorageDirectory();
    }
  }
}
