import 'dart:async';
import 'dart:developer';

import 'package:ruminate/core/data/datasources/local/local_reflection_datasource.dart';
import 'package:ruminate/core/data/model/reflection_model.dart';

class MockLocalFileReflectionDataSource implements LocalReflectionDatasource {
  bool? directoryExists;
  List<ReflectionModel>? _cachedReflections;
  List<ReflectionModel>? _mockReflections;

  MockLocalFileReflectionDataSource() {
    initDatasource();
  }

  @override
  FutureOr<List<ReflectionModel>?> fetchAllReflections() async {
    log("Cache $_cachedReflections");
    log("Mock $_mockReflections");
    log("fetchAllReflections called");
    if (_cachedReflections == null) {
      final reflections = await _fetchAllReflectionsFromFile();
      _cachedReflections = reflections;
    }
    log("Fetched reflections count: ${_cachedReflections?.length}");
    return _cachedReflections;
  }

  @override
  Future<void> insertReflection(ReflectionModel reflection) async {
    try {
      //Check storage initialized
      await initDatasource();

      log(reflection.title);

      log(_mockReflections.toString());
      _mockReflections ??= [];
      _mockReflections!.add(reflection);
      log(_mockReflections.toString());

      _cachedReflections = null;

      log("Success wrote!");
    } on Exception catch (e, stack) {
      throw Exception(
        "Exception at local reflection datasource. Method: insertReflectionIntoDirectory. Exception: $e StackTrace: $stack",
      );
    }
  }

  Future<List<ReflectionModel>?> _fetchAllReflectionsFromFile() async {
    try {
      await Future.delayed(Duration(seconds: 3));
      log("Try fetch");
      return _mockReflections;
    } on Exception catch (e, stack) {
      throw Exception(
        "Exception at local reflection datasource. Method: readAllReflectionsFromDirectory. Exception: $e StackTrace: $stack",
      );
    }
  }

  @override
  Future<void> initDatasource() async {
    //If the storage is not initialized we will do this
    //If it is initialized, we'll simply return
    if (directoryExists == null) {
      await Future.delayed(Duration(seconds: 2));
      directoryExists = true;
    } else {
      return;
    }
  }
}
