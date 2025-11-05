// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/enums/reflect_type_enum.dart';
import 'package:ruminate/features/reflection/data/model/reflection_model.dart';
import 'package:ruminate/features/reflection/data/model/reflection_step_model.dart';
import 'package:ruminate/features/reflection/domain/providers/daily_indepth_reflection_provider.dart';
import 'package:ruminate/features/reflection/domain/providers/daily_superficial_reflection_provider.dart';
import 'package:ruminate/features/reflection/domain/providers/monthly_reflection_provider.dart';
import 'package:ruminate/features/reflection/domain/providers/weekly_reflection_provider.dart';

class ReflectionViewModel extends StateNotifier<ReflectionStepModel?> {
  final Ref ref;
  ReflectionStepModel? firstStep;
  ReflectionStepModel? lastStep;
  ReflectionModel? currentModel;

  ReflectionViewModel(this.ref, [super.initial]);

  void setType(ReflectType type) {
    final dailySuperficial = ref.read(dailySuperficialReflectionProvider);
    final dailyIndepth = ref.read(dailyIndepthReflectionProvider);
    final monthly = ref.read(monthlyReflectionProvider);
    final weekly = ref.read(weeklyReflectionProvider);

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

    //A loop that creates a linked list
    for (int i = 0; currentModel!.steps.length > i; i++) {
      insertStep(currentModel!.steps[i]);
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
