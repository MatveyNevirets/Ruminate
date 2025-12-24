import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/auth/data/auth_params/login_params.dart';
import 'package:ruminate/core/auth/domain/repository/auth_repository.dart';
import 'package:ruminate/core/auth/providers/auth_repository_provider.dart';
import 'package:ruminate/core/auth/usecases/login_usecase.dart';

class FirebaseAuthViewModel extends StateNotifier<AsyncValue<User?>> {
  final AuthRepository authRepository;
  User? _cachedUser;
  bool _isLoading = false;

  FirebaseAuthViewModel({required this.authRepository})
    : super(const AsyncValue.loading()) {
    fetchUser();
  }

  FutureOr<User?> fetchUser() async {
    state = AsyncValue.loading();
    _cachedUser ??= await authRepository.signIn(FirebaseFetchUserCase());
    state = AsyncData(_cachedUser);
    return _cachedUser;
  }

  Future<void> loginWithGoogle(LoginUsecase loginUsecase) async {
    try {
      if (_isLoading) return;

      _isLoading = true;
      state = AsyncValue.loading();

      final user = await loginUsecase.execute(FirebaseGoogleCase());

      _cachedUser = null;

      state = AsyncValue.data(user);
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }
}

final firebaseAuthViewModel =
    StateNotifierProvider<FirebaseAuthViewModel, AsyncValue<User?>>(
      (ref) => FirebaseAuthViewModel(
        authRepository: ref.watch(authRepositoryProvider),
      ),
    );
