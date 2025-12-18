import 'package:firebase_auth/firebase_auth.dart';
import 'package:ruminate/features/auth/domain/auth_params/auth_params.dart';

abstract class LoginUsecase {
  Future<User> execute(LoginParams loginParams);
}
