import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/providers/start_provider.dart';
import 'package:ruminate/features/start/domain/repository/start_repository.dart';
import 'package:ruminate/features/start/enum/start_state.dart';
import 'package:ruminate/features/start/providers/start_repository_provider.dart';

class StartViewModel extends StateNotifier<StartState> {
  final Ref ref;
  bool _isLoading = false;

  StartViewModel(this.ref) : super(StartState.loading) {
    fetchDataValue();
  }

  void fetchDataValue() {
    try {
      if (_isLoading) return;

      _isLoading = true;
      state = StartState.loading;

      final isFirstEnter = ref.watch(isFirstStartProvider);
      final isHavePassword = ref.watch(isHavePasswordProvider);

      if (isFirstEnter && !isHavePassword) {
        log("OnBoarding");
        state = StartState.onBoarding;
      } else if (!isFirstEnter && isHavePassword) {
        state = StartState.password;
      } else if (!isFirstEnter && !isHavePassword) {
        state = StartState.authenticated;
      } else {
        state = StartState.onBoarding;
        log("OnBoarding else");
      }

      _isLoading = false;
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

  void changeState(StartState newState) {
    state = newState;
  }

  Future<void> setFirstEnter(bool value) async {
    try {
      final startRepository = ref.read(startRepositoryProvider);
      startRepository.setFirstValue(value);
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

  Future<void> setHavePassword(bool value) async {
    try {
      final startRepository = ref.read(startRepositoryProvider);
      startRepository.setHavePassword(value);
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }
}

final startViewModelProvider =
    StateNotifierProvider<StartViewModel, StartState>(
      (ref) => StartViewModel(ref),
    );
