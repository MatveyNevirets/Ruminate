import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/features/start/data/datasource/shared_preferences_start_datasource.dart';
import 'package:ruminate/features/start/data/datasource/start_datasource.dart';

final startDatasourceProvider = Provider<StartDatasource>((ref) => SharedPreferencesStartDatasource());