import 'dart:async';
import 'dart:developer' show log;
import 'dart:math' hide log;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/reflection/data/model/reflection_model.dart';
import 'package:ruminate/core/reflection/data/model/reflection_step_model.dart';
import 'package:ruminate/core/reflection/domain/reflection_repository.dart';
import 'package:ruminate/core/providers/reflection_datasource_repository_provider.dart';

class YouThoughtViewModel extends StateNotifier<AsyncValue<List<dynamic>?>> {
  final ReflectionRepository _reflectionRepository;
  final Random random = Random();
  ReflectionModel? _reflectionModel;
  bool _isLoading = false;

  YouThoughtViewModel(this._reflectionRepository)
    : super(const AsyncValue.loading()) {
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

        if (_reflectionModel?.steps != null &&
            _reflectionModel!.steps.isNotEmpty) {
          final randomStepInt = random.nextInt(_reflectionModel!.steps.length);
          log("randomStepInt: ${randomStepInt.toString()}");

          final currentRandomStep = _reflectionModel!.steps[randomStepInt];
          log("currentRandomStep: ${currentRandomStep.toString()}");

          final currentRandomQNA = _fetchRandomQNA(currentRandomStep);
          log("currentRandomQNA: ${currentRandomQNA.toString()}");

          if (currentRandomQNA != null) {
            state = AsyncValue.data([_reflectionModel, currentRandomQNA]);
          } else {
            state = AsyncValue.data(null);
          }
        } else {
          state = AsyncValue.data(null);
        }
      }
    } on Exception catch (e, stack) {
      state = AsyncValue.error(e, stack);
      throw Exception(
        "Exception YouThoughtScreen in method fetchRandomThought: $e StackTrace: $stack",
      );
    }
  }

  Map<String, String?>? _fetchRandomQNA(ReflectionStepModel step) {
    log("Fetch random");

    final randomQNAInt = random.nextInt(step.questionsAndAnswers.length);
    final currentRandomQNA = step.questionsAndAnswers[randomQNAInt];

    if (currentRandomQNA.values.first == null) {
      return null;
    }

    return currentRandomQNA;
  }
}

final youThoughtVMProvider =
    StateNotifierProvider<YouThoughtViewModel, AsyncValue<List<dynamic>?>>(
      (ref) => YouThoughtViewModel(ref.read(reflectionRepositoryProvider)),
    );
