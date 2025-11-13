import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/data/model/reflection_step_model.dart';
import 'package:ruminate/core/providers/reflection_datasource_repository_provider.dart';
import 'package:ruminate/features/personal_victories/presentation/viewmodel/personal_victories_view_model.dart';
import 'package:ruminate/features/reflection/presentation/view_model/reflection_view_model.dart';

final reflectionVM = StateNotifierProvider<ReflectionViewModel, ReflectionStepModel?>(
  (ref) =>
      ReflectionViewModel(ref, ref.read(reflectionRepositoryProvider), ref.read(personalVictoriesVMProvider.notifier)),
);
