import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/key_value_storage/providers/key_value_storage_provider.dart';
import 'package:ruminate/features/intro/data/repository/password_repository_impl.dart';
import 'package:ruminate/features/intro/domain/repository/password_repository.dart';

final passwordRepositoryProvider = Provider<PasswordRepository>(
  (ref) => PasswordRepositoryImpl(
    keyValueStorage: ref.watch(keyValueStorageProvider),
  ),
);
