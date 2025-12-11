import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/features/start_screen/domain/repository/start_repository.dart';
import 'package:ruminate/features/start_screen/providers/start_repository_provider.dart';

class StartViewModel extends StateNotifier<AsyncValue<List<bool>>> {
  final StartRepository _startRepository;
  bool _isLoading = false;

  StartViewModel(this._startRepository) : super(const AsyncValue.loading()) {
    fetchDataValue();
  }

  Future<void> fetchDataValue() async {
    try {
      if (_isLoading) return;

      _isLoading = true;
      state = AsyncValue.loading();

      final fetchedValues = await _startRepository.fetchStartValues();

      state = AsyncValue.data(fetchedValues);

      _isLoading = false;
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

  Future<void> setFirstEnter(bool value) async {
    try {
      await _startRepository.setFirstValue(value);
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }

  Future<void> setHavePassword(bool value) async {
    try {
      await _startRepository.setHavePassword(value);
    } on Object catch (e, stack) {
      throw Exception("$e StackTrace: $stack");
    }
  }
}

final startViewModelProvider =
    StateNotifierProvider<StartViewModel, AsyncValue<List<bool>>>(
      (ref) => StartViewModel(ref.watch(startRepositoryProvider)),
    );
