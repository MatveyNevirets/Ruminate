import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/reflection/data/model/reflection_model.dart';
import 'package:ruminate/features/reflection/domain/reflections/monthly_reflection.dart';

final monthlyReflectionProvider = Provider<ReflectionModel>((ref) => MonthlyReflection());
