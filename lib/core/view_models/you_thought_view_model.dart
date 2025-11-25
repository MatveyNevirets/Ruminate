import 'dart:developer' show log;
import 'dart:math' hide log;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/data/model/reflection_model.dart';
import 'package:ruminate/core/data/model/reflection_step_model.dart';
import 'package:ruminate/core/domain/reflection_repository.dart';
import 'package:ruminate/core/providers/reflection_datasource_repository_provider.dart';

class YouThoughtViewModel extends StateNotifier<AsyncValue<Map<String, String?>?>> {
  final ReflectionRepository _reflectionRepository;
  final Random random = Random();
  ReflectionModel? _reflectionModel;
  bool _isLoading = false;

  YouThoughtViewModel(this._reflectionRepository) : super(const AsyncValue.loading()) {
    fetchRandomThought();
  }

  ReflectionModel? get reflection => _reflectionModel;

  Future<void> fetchRandomThought() async {
    if (_isLoading) return;

    _reflectionModel = null;
    state = AsyncValue.loading();
    _isLoading = true;

    try {
      final reflections = await _reflectionRepository.fetchAllReflections();

      if (reflections == null || reflections.isEmpty) {
        state = AsyncValue.data(null);
        return;
      } else {
        log("reflections: ${reflection.toString()}");
        final randomReflectionInt = random.nextInt(reflections.length);
        log("randomReflectionInt: ${randomReflectionInt.toString()}");

        _reflectionModel = reflections[randomReflectionInt];
        log("_reflectionModel: ${_reflectionModel.toString()}");

        final randomStepInt = random.nextInt(_reflectionModel!.steps.length);
        log("randomStepInt: ${randomStepInt.toString()}");

        final currentRandomStep = _reflectionModel!.steps[randomStepInt];
        log("currentRandomStep: ${currentRandomStep.toString()}");

        final currentRandomQNA = _fetchRandomQNA(currentRandomStep);
        log("currentRandomQNA: ${currentRandomQNA.toString()}");

        state = AsyncValue.data(currentRandomQNA);
      }
    } on Exception catch (e, stack) {
      state = AsyncValue.error(e, stack);
      throw Exception("Exception YouThoughtScreen in method fetchRandomThought: $e StackTrace: $stack");
    }
  }

  Map<String, String?> _fetchRandomQNA(ReflectionStepModel step) {
    bool isEmptyAnswer = true;
    late Map<String, String?> currentRandomQNA;

    while (isEmptyAnswer) {
      final randomQNAInt = random.nextInt(step.questionsAndAnswers.length);
      log("randomQNAInt: ${randomQNAInt.toString()}");
      currentRandomQNA = step.questionsAndAnswers[randomQNAInt];
      log("currentRandomQNA: ${currentRandomQNA.toString()}");

      if (currentRandomQNA.values.first == null) {
        isEmptyAnswer = true;
        log("isEmptyAnswer: ${isEmptyAnswer.toString()}");
      } else {
        log("isEmptyAnswer: ${isEmptyAnswer.toString()}");
        isEmptyAnswer = false;
        break;
      }
    }
    log("Return: ${currentRandomQNA.toString()}");
    return currentRandomQNA;
  }
}

final youThoughtVMProvider = StateNotifierProvider<YouThoughtViewModel, AsyncValue<Map<String, String?>?>>(
  (ref) => YouThoughtViewModel(ref.read(reflectionRepositoryProvider)),
);
