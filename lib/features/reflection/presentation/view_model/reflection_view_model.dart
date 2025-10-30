// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/enums/reflect_type_enum.dart';
import 'package:ruminate/features/reflection/data/model/reflection_step_model.dart';
import 'package:ruminate/features/reflection/domain/reflections/daily_reflection_superficial.dart';
import 'package:ruminate/features/reflection/domain/repository/reflection_repository.dart';

class ReflectionViewModel extends StateNotifier<ReflectionStepModel?> implements ReflectionRepository {
  final Ref ref;
  ReflectionStepModel? firstStep;
  ReflectionStepModel? lastStep;

  ReflectionViewModel(this.ref, [super.initial]) {
    final daily = ref.watch(dailySuperficialProvider);

    for (int i = 0; daily.steps.length > i; i++) {
      insertStep(daily.steps[i]);
    }

    state = firstStep!;
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

  @override
  void nextStep() {
    if (state?.next == null) {
      completeReflection();
    } else {
      state = state!.next;
      log("Title current step: ${state?.title}");
    }
  }

  @override
  void prevStep() {
    if (state?.prev == null) {
      log("Prev is null");
    } else {
      state = state!.prev;
      log("Title current step: ${state?.title}");
    }
  }

  @override
  void completeReflection() {
    log("Reflection completed");
  }
}

final reflectionVM = StateNotifierProvider<ReflectionViewModel, ReflectionStepModel?>(
  (ref) => ReflectionViewModel(ref),
);
