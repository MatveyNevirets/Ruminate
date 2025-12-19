import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/reflection/data/model/reflection_model.dart';
import 'package:ruminate/features/reflection/domain/reflections/weekly_reflection.dart';

final weeklyReflectionProvider = Provider<ReflectionModel>((ref) => WeeklyReflection());
