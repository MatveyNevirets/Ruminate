// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/data/model/reflection_model.dart';
import 'package:ruminate/core/data/model/reflection_step_model.dart';
import 'package:ruminate/core/domain/reflection_repository.dart';
import 'package:ruminate/core/enums/reflect_type_enum.dart';
import 'package:ruminate/features/completed_reflections/presentation/providers/completed_reflections_view_model.dart';
import 'package:ruminate/features/personal_victories/presentation/viewmodel/personal_victories_view_model.dart';
import 'package:ruminate/features/reflection/domain/providers/daily_indepth_reflection_provider.dart';
import 'package:ruminate/features/reflection/domain/providers/daily_superficial_reflection_provider.dart';
import 'package:ruminate/features/reflection/domain/providers/monthly_reflection_provider.dart';
import 'package:ruminate/features/reflection/domain/providers/weekly_reflection_provider.dart';
import 'package:ruminate/features/statistics/data/models/statistics_model.dart';
import 'package:ruminate/features/statistics/domain/repository/statistics_repository.dart';
import 'package:ruminate/features/statistics/presentation/view_model/statistics_view_model.dart';

class ReflectionViewModel extends StateNotifier<ReflectionStepModel?> {
  final Ref ref;
  final ReflectionRepository reflectionRepository;
  final PersonalVictoriesViewModel personalVictoriesViewModel;
  final StatisticsRepository statisticsRepository;

  ReflectionStepModel? firstStep;
  ReflectionStepModel? lastStep;
  ReflectionModel? currentReflection;

  List<String> personalVictories = [];
  String? energyGenerator,
      energyKiller,
      importantToWork,
      averageConfident,
      fears;

  ReflectionViewModel(
    this.ref,
    this.reflectionRepository,
    this.personalVictoriesViewModel,
    this.statisticsRepository, [
    super.initial,
  ]);

  void setType(ReflectType type) {
    currentReflection = null;
    state = null;
    firstStep = null;
    lastStep = null;

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
      final qnaKey = qna.keys.first;

      qna[qnaKey] = answers[i].isEmpty ? null : answers[i];

      //Checks the key for the word "victory"
      if ((qnaKey.contains("Побед") || qnaKey.contains("стал(а) лучше")) &&
          answers[i].isNotEmpty) {
        //Then adds to the personalVictories list
        personalVictories.add(answers[i]);
        //Then adds to the fears list
      } else if (qnaKey.contains("стра") ||
          qnaKey.contains("боюс") && answers[i].isNotEmpty) {
        fears = answers[i];
        //Then adds to the energy generators list
      } else if (qnaKey.contains("ресу") ||
          qnaKey.contains("помогало сегодня") ||
          qnaKey.contains("больше всего энергии") && answers[i].isNotEmpty) {
        energyGenerator = answers[i];
        //Then adds to the energy killers list
      } else if (qnaKey.contains("энергетическим вампиром") &&
          answers[i].isNotEmpty) {
        energyKiller = answers[i];
        //Then adds to the important to work list
      } else if (qnaKey.contains("конкретный шаг") ||
          qnaKey.contains("начну делать по-другому") ||
          qnaKey.contains("я откажусь") && answers[i].isNotEmpty) {
        importantToWork = answers[i];
      }

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

  Future<void> completeReflection(BuildContext context) async {
    context.go("/home");
    await reflectionRepository.insertReflection(currentReflection!);

    await personalVictoriesViewModel.insertVictories(personalVictories);

    final newStatisticsModel = StatisticsModel(
      date: DateTime.now(),
      totalReflections: 0,
      totalVictories: 0,
      energyGenerators: energyGenerator,
      energyKillers: energyKiller,
      importantToWork: importantToWork,
      fears: fears,
    );

    log(newStatisticsModel.toString());

    await statisticsRepository.insertData(newStatisticsModel);
    await ref.read(statisticsViewModelProvider.notifier).fetchData();

    await ref.read(completedReflectionsProvider.notifier).refresh();
  }
}
