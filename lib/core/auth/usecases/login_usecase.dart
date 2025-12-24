import 'package:firebase_auth/firebase_auth.dart';
import 'package:ruminate/core/auth/data/auth_params/login_params.dart';

abstract class LoginUsecase {
  Future<User?> execute(FirebaseAuthCase loginCase);
}
