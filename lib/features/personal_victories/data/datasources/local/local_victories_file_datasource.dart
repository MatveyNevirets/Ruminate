import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:ruminate/features/personal_victories/data/datasources/local/local_victories_datasource.dart';

class LocalVictoriesFileDatasource implements LocalVictoriesDatasource {
  Directory? _directory;
  List<String>? _cachedVictories;

  LocalVictoriesFileDatasource() {
    initDatasource();
  }

  @override
  Future<void> insertVictories(List<String> victories) async {
    try {
      await initDatasource();

      // Recieves file
      final file = File("${_directory!.path}/victoriesData/personal_victories.md");
      await file.parent.create(recursive: true);
      await file.create(recursive: true);

      // Recieve the data to check in future
      final jsonVictories = await file.readAsString();

      // Write if first data
      if (!await file.exists() || jsonVictories.isEmpty) {
        final victoriesMap = {"victories": victories};
        await file.writeAsString(jsonEncode(victoriesMap));
      } else {
        // If we have some data into file
        // In first, we'll recieve last data
        final mapVictories = jsonDecode(jsonVictories) as Map<String, dynamic>;
        final recievedVictories = mapVictories['victories'] as List<dynamic>;

        // Then creates new list for victories
        final List<String> newVictories = [...recievedVictories, ...victories];

        // Clear cache because the user must will see updated data
        _cachedVictories = null;

        // In end, we have full updated victories
        final newMap = {'victories': newVictories};
        await file.writeAsString(jsonEncode(newMap));

        log(recievedVictories.toString());
      }
    } on Exception catch (e, stack) {
      throw Exception("Exception at LocalFileVictoriesDatasource, method addVictories(): $e StackTrace: $stack");
    }
  }

  @override
  FutureOr<List<String>?> fetchVictories() async {
    try {
      if (_cachedVictories == null) {
        await initDatasource();

        // Recieves file
        final file = File("${_directory!.path}/victoriesData/personal_victories.md");
        await file.parent.create(recursive: true);
        await file.create(recursive: true);

        // Recieves last data
        final jsonVictories = await file.readAsString();

        // If we have a whole file created
        // But there is an empty string -> just returns
        // To show the user a screen with a message
        if (jsonVictories.isEmpty) return null;

        final mapVictories = jsonDecode(jsonVictories) as Map<String, dynamic>;
        final victories = mapVictories['victories'] as List<dynamic>;

        // Creates new list with List<String> data type
        List<String> newVictories = [];

        for (String victory in victories) {
          // Fills the new list
          newVictories.add(victory);
        }

        // Adds this one to cache
        _cachedVictories = newVictories;
      }

      // And in anyway we'll return the cache data
      log(_cachedVictories.toString());
      return _cachedVictories!;
    } on Exception catch (e, stack) {
      throw Exception("Exception at LocalFileVictoriesDatasource in method fetchVictories(): $e StackTrace: $stack");
    }
  }

  @override
  Future<void> initDatasource() async {
    while (_directory == null) {
      _directory = await getExternalStorageDirectory();
    }
  }
}
