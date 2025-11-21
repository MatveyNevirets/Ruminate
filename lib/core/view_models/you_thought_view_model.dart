import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/data/model/reflection_step_model.dart';
import 'package:ruminate/core/domain/reflection_repository.dart';
import 'package:ruminate/core/providers/reflection_datasource_repository_provider.dart';

class YouThoughtViewModel extends StateNotifier<AsyncValue<Map<String, String?>>> {
  final ReflectionRepository _reflectionRepository;
  final Random random = Random();
  bool _isLoading = false;

  YouThoughtViewModel(this._reflectionRepository) : super(const AsyncValue.loading());

  Future<void> fetchRandomThought() async {
    state = AsyncValue.loading();
    _isLoading = true;

    if (_isLoading) return;

    try {
      final reflections = await _reflectionRepository.fetchAllReflections();

      final randomReflectionInt = random.nextInt(reflections.length);

      final currentRandomReflection = reflections[randomReflectionInt];

      final randomStepInt = random.nextInt(currentRandomReflection.steps.length);

      final currentRandomStep = currentRandomReflection.steps[randomStepInt];

      final currentRandomQNA = _fetchRandomQNA(currentRandomStep);

      state = AsyncValue.data(currentRandomQNA);
    } on Object catch (e, stack) {
      state = AsyncValue.error(e, stack);
      throw Exception("Exception YouThoughtScreen in method fetchRandomThought: $e StackTrace: $stack");
    }
  }

  Map<String, String?> _fetchRandomQNA(ReflectionStepModel step) {
    bool isEmptyAnswer = true;
    late Map<String, String?> currentRandomQNA;

    while (isEmptyAnswer) {
      final randomQNAInt = random.nextInt(step.questionsAndAnswers.length);
      currentRandomQNA = step.questionsAndAnswers[randomQNAInt];

      if (currentRandomQNA.values.first == null) {
        isEmptyAnswer = false;
      } else {
        isEmptyAnswer = true;
      }
    }
    return currentRandomQNA;
  }
}

final youThoughtVMProvider = StateNotifierProvider<YouThoughtViewModel, AsyncValue<Map<String, String?>>>(
  (ref) => YouThoughtViewModel(ref.read(reflectionRepositoryProvider)),
);
