import 'package:firebase_auth/firebase_auth.dart';
import 'package:ruminate/core/auth/data/auth_params/login_params.dart';
import 'package:ruminate/core/auth/domain/repository/auth_repository.dart';
import 'package:ruminate/core/auth/usecases/login_usecase.dart';

class GoogleLoginUsecase implements LoginUsecase {
  @override
  Future<User?> execute(FirebaseAuthCase loginCase) async {
    try {
      final user = await loginCase.login();

      return user;
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }
}
