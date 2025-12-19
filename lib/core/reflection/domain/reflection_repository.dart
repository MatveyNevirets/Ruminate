import 'dart:async';

import 'package:ruminate/core/reflection/data/model/reflection_model.dart';

abstract class ReflectionRepository {
  FutureOr<List<ReflectionModel>?> fetchAllReflections();
  Future<void> insertReflection(ReflectionModel reflection);
}
