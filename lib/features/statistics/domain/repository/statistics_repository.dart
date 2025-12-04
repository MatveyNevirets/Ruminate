import 'dart:async';

import 'package:ruminate/features/statistics/data/models/statistics_model.dart';

abstract class StatisticsRepository {
  Future<void> insertData(StatisticsModel model);
  FutureOr<List<StatisticsModel>?> fetchData();
}
