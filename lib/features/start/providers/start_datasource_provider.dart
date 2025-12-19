import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/key_value_storage/data/datasource/shared_preferences_start_datasource.dart';
import 'package:ruminate/core/key_value_storage/data/datasource/key_value_storage.dart';

final startDatasourceProvider = Provider<KeyValueStorage>(
  (ref) => SharedPreferencesStorage(),
);
