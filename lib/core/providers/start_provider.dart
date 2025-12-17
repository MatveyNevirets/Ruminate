import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/consts/start_consts.dart';
import 'package:ruminate/features/start/providers/start_repository_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final startDataProvider = FutureProvider<bool>((ref) async {
  final startRepository = ref.watch(startRepositoryProvider);

  final startValues = await startRepository.fetchStartValues();

  final isFirstStart = startValues[0];
  final isHavePassword = startValues[1];

  ref.read(isFirstStartProvider.notifier).state = isFirstStart;
  ref.read(isHavePasswordProvider.notifier).state = isHavePassword;

  return true;
});

final isFirstStartProvider = StateProvider<bool>((ref) => true);
final isHavePasswordProvider = StateProvider<bool>((ref) => false);
