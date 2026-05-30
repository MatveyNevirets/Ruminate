// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/reflection/data/model/reflection_model.dart';
import 'package:ruminate/core/reflection/data/model/reflection_step_model.dart';
import 'package:ruminate/core/reflection/domain/reflection_repository.dart';
import 'package:ruminate/core/reflection/enums/reflect_type_enum.dart';
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

  ReflectionModel _cloneReflectionModel(ReflectionModel source) {
    final clonedSteps = source.steps.map(_cloneStep).toList(growable: false);
    return source.copyWith(steps: clonedSteps);
  }

  ReflectionStepModel _cloneStep(ReflectionStepModel step) {
    final clonedQna = step.questionsAndAnswers
        .map((qna) => Map<String, String?>.from(qna))
        .toList(growable: false);

    return step.copyWith(questionsAndAnswers: clonedQna);
  }

  void _resetRuntimeState() {
    firstStep = null;
    lastStep = null;
    currentReflection = null;
    personalVictories.clear();
    energyGenerator = null;
    energyKiller = null;
    importantToWork = null;
    averageConfident = null;
    fears = null;
    state = null;
  }

  void setType(ReflectType type) {
    _resetRuntimeState();

    final dailySuperficial = ref.read(dailySuperficialReflectionProvider);
    final dailyIndepth = ref.read(dailyIndepthReflectionProvider);
    final monthly = ref.read(monthlyReflectionProvider);
    final weekly = ref.read(weeklyReflectionProvider);

    final ReflectionModel sourceReflection;

    switch (type) {
      case ReflectType.dailySuperficital:
        sourceReflection = dailySuperficial;
        break;
      case ReflectType.dailyIndepth:
        sourceReflection = dailyIndepth;
        break;
      case ReflectType.monthly:
        sourceReflection = monthly;
        break;
      case ReflectType.weekly:
        sourceReflection = weekly;
        break;
      default:
        throw Exception("Not found $type reflection type");
    }

    // Always work with a fresh copy so old answers never leak into a new run.
    currentReflection = _cloneReflectionModel(sourceReflection);

    for (int i = 0; i < currentReflection!.steps.length; i++) {
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
    final index = currentReflection!.steps.indexOf(state!);
    final List<Map<String, String?>> newQnaList = [];

    for (int i = 0; i < answers.length; i++) {
      final qna = currentReflection!.steps[index].questionsAndAnswers[i];
      final qnaKey = qna.keys.first;

      qna[qnaKey] = answers[i].isEmpty ? null : answers[i];

      if ((qnaKey.contains("Побед") || qnaKey.contains("стал(а) лучше")) &&
          answers[i].isNotEmpty) {
        personalVictories.add(answers[i]);
      } else if (qnaKey.contains("стра") ||
          qnaKey.contains("боюс") && answers[i].isNotEmpty) {
        fears = answers[i];
      } else if (qnaKey.contains("ресу") ||
          qnaKey.contains("помогало сегодня") ||
          qnaKey.contains("больше всего энергии") && answers[i].isNotEmpty) {
        energyGenerator = answers[i];
      } else if (qnaKey.contains("энергетическим вампиром") &&
          answers[i].isNotEmpty) {
        energyKiller = answers[i];
      } else if (qnaKey.contains("конкретный шаг") ||
          qnaKey.contains("начну делать по-другому") ||
          qnaKey.contains("я откажусь") && answers[i].isNotEmpty) {
        importantToWork = answers[i];
      }

      newQnaList.add(qna);
    }

    final newState = state!.copyWith(questionsAndAnswers: newQnaList);

    final List<ReflectionStepModel> newSteps = [];

    for (ReflectionStepModel step in currentReflection!.steps) {
      if (step == state) {
        step = newState;
      }
      newSteps.add(step);
    }

    currentReflection = currentReflection!.copyWith(steps: newSteps);

    if (state?.next == null) {
      completeReflection(context);
    } else {
      state = state!.next;
    }
  }

  void prevStep() {
    if (state?.prev != null) {
      state = state!.prev;
    }
  }

  Future<void> completeReflection(BuildContext context) async {
    final reflectionToSave = currentReflection;

    if (reflectionToSave == null) return;

    context.go("/home");

    await reflectionRepository.insertReflection(reflectionToSave);
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

    // Important: reset everything so the next run starts from a clean state.
    _resetRuntimeState();
  }
}
