// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/enums/reflect_type_enum.dart';
import 'package:ruminate/features/reflection/data/model/reflection_model.dart';
import 'package:ruminate/features/reflection/data/model/reflection_step_model.dart';
import 'package:ruminate/features/reflection/domain/reflections/daily_reflection_indepth.dart';
import 'package:ruminate/features/reflection/domain/reflections/daily_reflection_superficial.dart';
import 'package:ruminate/features/reflection/domain/reflections/monthly_reflection.dart';
import 'package:ruminate/features/reflection/domain/reflections/weekly_reflection.dart';

class ReflectionViewModel extends StateNotifier<ReflectionStepModel?> {
  final Ref ref;
  ReflectionStepModel? firstStep;
  ReflectionStepModel? lastStep;

  ReflectionViewModel(this.ref, [super.initial]);

  void setType(ReflectType type) {
    ReflectionModel? currentModel;
    final dailySuperficial = ref.read(dailySuperficialProvider);
    final dailyIndepth = ref.read(dailyIndepthProvider);
    final monthly = ref.read(monthlyProvider);
    final weekly = ref.read(weeklyProvider);

    switch (type) {
      case ReflectType.dailySuperficital:
        currentModel = dailySuperficial;
      case ReflectType.dailyIndepth:
        currentModel = dailyIndepth;
      case ReflectType.monthly:
        currentModel = monthly;
      case ReflectType.weekly:
        currentModel = weekly;

      default:
        throw Exception("Not found $type reflection type");
    }

    for (int i = 0; currentModel.steps.length > i; i++) {
      insertStep(currentModel.steps[i]);
    }

    state = firstStep;
  }

  void insertStep(ReflectionStepModel? newStep) {
    if (firstStep == null) {
      firstStep = newStep;
    } else {
      newStep!.prev = lastStep;
      lastStep?.next = newStep;
    }
    lastStep = newStep;
  }

  void nextStep() {
    if (state?.next == null) {
      completeReflection();
    } else {
      state = state!.next;
    }
  }

  void prevStep() {
    if (state?.prev == null) {
    } else {
      state = state!.prev;
    }
  }

  void completeReflection() {
    log("Reflection completed");
  }
}

final reflectionVM = StateNotifierProvider<ReflectionViewModel, ReflectionStepModel?>(
  (ref) => ReflectionViewModel(ref),
);
