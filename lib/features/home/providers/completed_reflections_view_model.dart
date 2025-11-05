import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/features/reflection/data/model/reflection_model.dart';
import 'package:ruminate/features/reflection/data/providers/local_file_datasource_provider.dart';

class CompletedReflectionsViewModel extends StateNotifier<AsyncValue<List<ReflectionModel>>> {
  final Ref _ref;
  bool _isLoading = false;

  CompletedReflectionsViewModel(this._ref) : super(const AsyncValue.loading()) {
    _fetchReflections();
  }

  Future<void> _fetchReflections() async {
    if (_isLoading) return;

    _isLoading = true;
    state = AsyncValue.loading();

    try {
      final localReflectionDataSource = _ref.read(localFileDataSourceProvider);
      final reflections = await localReflectionDataSource.fetchAllReflections();
      state = AsyncValue.data(reflections);
    } on Exception catch (e, stack) {
      state = AsyncValue.error(e, stack);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> refresh() async {
    await _fetchReflections();
  }
}

final completedReflectionsProvider =
    StateNotifierProvider<CompletedReflectionsViewModel, AsyncValue<List<ReflectionModel>>>(
      (ref) => CompletedReflectionsViewModel(ref),
    );
