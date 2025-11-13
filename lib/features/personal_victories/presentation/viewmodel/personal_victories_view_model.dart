// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/features/personal_victories/domain/repository/victories_repository.dart';
import 'package:ruminate/features/personal_victories/provider/victories_repository_provider.dart';

class PersonalVictoriesViewModel extends StateNotifier<AsyncValue<List<String>?>> {
  final VictoriesRepository _victoriesRepository;
  bool _isLoading = false;

  PersonalVictoriesViewModel(this._victoriesRepository) : super(AsyncValue.loading()) {
    _fetchVictories();
  }

  Future<void> insertVictories(List<String> victories) async {
    try {
      await _victoriesRepository.insertVictories(victories);
      await refresh();
    } on Exception catch (e, stack) {
      throw Exception("Exception at PersonalVictoriesViewModel in method insertVictories(): $e StackTrace: $stack");
    }
  }

  Future<void> _fetchVictories() async {
    if (_isLoading) return;

    _isLoading = true;
    state = AsyncValue.loading();

    try {
      final victories = await _victoriesRepository.fetchVictories();

      state = AsyncValue.data(victories);
    } on Exception catch (e, stack) {
      state = AsyncValue.error(e, stack);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> refresh() async {
    await _fetchVictories();
  }
}

final personalVictoriesVMProvider = StateNotifierProvider<PersonalVictoriesViewModel, AsyncValue<List<String>?>>(
  (ref) => PersonalVictoriesViewModel(ref.watch(victoriesRepositoryProvider)),
);
