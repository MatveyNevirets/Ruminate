import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/features/intro/domain/repository/password_repository.dart';
import 'package:ruminate/features/intro/providers/password_repository_provider.dart';

class PasswordViewModel extends StateNotifier<AsyncValue<bool>> {
  late final PasswordRepository passwordRepository;
  bool _isLoading = false;

  PasswordViewModel({required this.passwordRepository})
    : super(const AsyncValue.loading());

  Future<void> setPassword(String password) async {
    try {
      if (_isLoading) return;

      _isLoading = true;
      state = AsyncValue.loading();

      await passwordRepository.writePassword(password);

      _isLoading = false;
      state = AsyncValue.data(true);
    } on Object catch (e, stack) {
      state = AsyncValue.error(e, stack);
      throw Exception("$e StackTrace: $stack");
    }
  }

  Future<void> verifyPassword(String password) async {
    try {
      if (_isLoading) return;

      _isLoading = true;
      state = AsyncValue.loading();

      final savedPassword = await passwordRepository.recievePassword();

      _isLoading = false;
      if (savedPassword != null && savedPassword == password) {
        log("Correct password");
        state = AsyncValue.data(true);
      } else if (savedPassword != password) {
        log("Invalid password");
        state = AsyncValue.data(false);
      }
    } on Object catch (e, stack) {
      state = AsyncValue.error(e, stack);
      throw Exception("$e StackTrace: $stack");
    }
  }
}

final passwordViewModelProvider =
    StateNotifierProvider<PasswordViewModel, AsyncValue<bool>>(
      (ref) => PasswordViewModel(
        passwordRepository: ref.watch(passwordRepositoryProvider),
      ),
    );
