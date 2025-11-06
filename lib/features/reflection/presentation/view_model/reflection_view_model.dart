// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/data/datasources/local_reflection_datasource/local_reflection_datasource.dart';
import 'package:ruminate/core/data/model/reflection_model.dart';
import 'package:ruminate/core/data/model/reflection_step_model.dart';
import 'package:ruminate/core/enums/reflect_type_enum.dart';
import 'package:ruminate/features/reflection/domain/providers/daily_indepth_reflection_provider.dart';
import 'package:ruminate/features/reflection/domain/providers/daily_superficial_reflection_provider.dart';
import 'package:ruminate/features/reflection/domain/providers/monthly_reflection_provider.dart';
import 'package:ruminate/features/reflection/domain/providers/weekly_reflection_provider.dart';

class ReflectionViewModel extends StateNotifier<ReflectionStepModel?> {
  final Ref ref;
  final LocalFileDataSource localFileDataSource;

  ReflectionStepModel? firstStep;
  ReflectionStepModel? lastStep;
  ReflectionModel? currentReflection;

  ReflectionViewModel(this.ref, this.localFileDataSource, [super.initial]);

  void setType(ReflectType type) {
    final dailySuperficial = ref.read(dailySuperficialReflectionProvider);
    final dailyIndepth = ref.read(dailyIndepthReflectionProvider);
    final monthly = ref.read(monthlyReflectionProvider);
    final weekly = ref.read(weeklyReflectionProvider);

    switch (type) {
      case ReflectType.dailySuperficital:
        currentReflection = dailySuperficial;
      case ReflectType.dailyIndepth:
        currentReflection = dailyIndepth;
      case ReflectType.monthly:
        currentReflection = monthly;
      case ReflectType.weekly:
        currentReflection = weekly;

      default:
        throw Exception("Not found $type reflection type");
    }

    //A loop that creates a linked list
    for (int i = 0; currentReflection!.steps.length > i; i++) {
      insertStep(currentReflection!.steps[i]);
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

  void nextStep(List<String> answers, BuildContext context) {
    //Gets an index of the current step
    final index = currentReflection!.steps.indexOf(state!);
    final List<Map<String, String?>> newQnaList = [];

    //Here we iterate through each question and answer,
    //Replacing null values ​​with the answers just entered by the user.
    for (int i = 0; i < answers.length; i++) {
      final qna = currentReflection!.steps[index].questionsAndAnswers[i];
      qna[qna.keys.first] = answers[i];
      //And we add them to a new list of questions and answers for future reference
      newQnaList.add(qna);
    }

    //Creates a new step of reflection, replaces the last questions and answers with new ones
    final newState = state!.copyWith(questionsAndAnswers: newQnaList);

    final List<ReflectionStepModel> newSteps = [];

    //We go through all the steps to find which ReflectionStepModel needs to be changed.
    for (ReflectionStepModel step in currentReflection!.steps) {
      if (step == state) {
        step = newState;
      }
      newSteps.add(step);
    }

    //Updates the ReflectionModel with modified steps
    currentReflection = currentReflection!.copyWith(steps: newSteps);
    if (state?.next == null) {
      completeReflection(context);
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

  void completeReflection(BuildContext context) {
    localFileDataSource.insertReflectionIntoDirectory(currentReflection!);
    context.go("/home");
    log("Reflection completed");
  }
}
