// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/features/reflection/data/model/reflection_model.dart';
import 'package:ruminate/features/reflection/data/model/reflection_step_model.dart';
import 'package:ruminate/features/reflection/domain/reflections/daily_reflection_superficial.dart';
import 'package:ruminate/features/reflection/domain/repository/reflection_repository.dart';

class ReflectionViewModel extends StateNotifier<ReflectionStepModel?> implements ReflectionRepository {
  final Ref ref;

  ReflectionViewModel(this.ref, [super.initial]) {
    final daily = ref.watch(dailySuperficialProvider);
    state = daily.steps[0];
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
    // TODO: implement prevStep
  }

  @override
  void completeReflection() {
    log("Reflection completed");
  }
}

final dailySuperficialProvider = Provider<ReflectionModel>((ref) => DailySuperficialReflection());

final dailySuperficialReflectionVM = StateNotifierProvider<ReflectionViewModel, ReflectionStepModel?>(
  (ref) => ReflectionViewModel(ref),
);
