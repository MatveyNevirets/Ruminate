import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/auth/data/repository/auth_repository_impl.dart';
import 'package:ruminate/core/auth/domain/repository/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(),
);
