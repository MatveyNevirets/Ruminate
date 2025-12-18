import 'package:firebase_auth/firebase_auth.dart';
import 'package:ruminate/features/auth/data/datasources/auth_service.dart';
import 'package:ruminate/features/auth/domain/auth_params/auth_params.dart';

class FirebaseAuthService implements AuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User> login(LoginParams loginParams) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
