import 'package:firebase_auth/firebase_auth.dart';
import 'package:ruminate/features/auth/domain/auth_params/auth_params.dart';
import 'package:ruminate/features/auth/domain/repository/auth_repository.dart';
import 'package:ruminate/features/auth/domain/usecases/login_usecase.dart';

class GoogleLoginUsecase implements LoginUsecase {
  final AuthRepository authRepository;

  GoogleLoginUsecase({required this.authRepository});

  @override
  Future<User> execute(LoginParams loginParams) async {
    if (loginParams.runtimeType is! GoogleLoginParams) {
      throw Exception();
    }

    throw UnimplementedError();
  }
}
