import 'package:firebase_auth/firebase_auth.dart';
import 'package:ruminate/core/auth/data/auth_params/login_params.dart';

abstract class AuthRepository {
  Future<User?> signIn(FirebaseAuthCase loginParams);
  Future<void> logout(FirebaseAuthCase loginCase);
}
