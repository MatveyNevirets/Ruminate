import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/features/reflection/data/model/reflection_model.dart';
import 'package:ruminate/features/reflection/domain/reflections/daily_indepth_reflection.dart';

final dailyIndepthReflectionProvider = Provider<ReflectionModel>((ref) => DailyIndepthReflection());
