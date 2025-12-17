import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/providers/start_provider.dart';
import 'package:ruminate/features/start/domain/repository/start_repository.dart';
import 'package:ruminate/features/start/enum/auth_state.dart';
import 'package:ruminate/features/start/providers/start_repository_provider.dart';

class StartViewModel extends StateNotifier<AuthState> {
  final Ref ref;
  bool _isLoading = false;

  StartViewModel(this.ref) : super(AuthState.loading) {
    fetchDataValue();
  }

  Future<void> fetchDataValue() async {
    try {
      if (_isLoading) return;

      _isLoading = true;
      state = AuthState.loading;

      final isFirstEnter = ref.watch(isFirstStartProvider);
      final isHavePassword = ref.watch(isHavePasswordProvider);

      if (isFirstEnter && !isHavePassword) {
        state = AuthState.onBoarding;
      } else if (!isFirstEnter && isHavePassword) {
        state = AuthState.password;
      } else if (!isFirstEnter && !isHavePassword) {
        state = AuthState.authenticated;
      }

      _isLoading = false;
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
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

final startViewModelProvider = StateNotifierProvider<StartViewModel, AuthState>(
  (ref) => StartViewModel(ref),
);
