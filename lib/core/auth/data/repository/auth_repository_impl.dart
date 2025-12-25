import 'package:firebase_auth/firebase_auth.dart';
import 'package:ruminate/core/auth/data/auth_params/login_params.dart';
import 'package:ruminate/core/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User?> signIn(FirebaseAuthCase loginCase) async {
    return await loginCase.login();
  }

  @override
  Future<void> logout(FirebaseAuthCase loginCase) async {
    await loginCase.logout();
  }
}
