import 'package:ruminate/features/auth/domain/auth_params/auth_params.dart';

abstract class AuthRepository {
  Future<void> login(LoginParams loginParams);
}
