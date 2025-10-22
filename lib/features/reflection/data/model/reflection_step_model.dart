import 'package:freezed_annotation/freezed_annotation.dart';

part 'reflection_step_model.freezed.dart';
part 'reflection_step_model.g.dart';

@freezed
abstract class ReflectionStepModel with _$ReflectionStepModel {
  const factory ReflectionStepModel({
    required String title,
    required String description,
    required List<String> questions,
    ReflectionStepModel? prev,
    ReflectionStepModel? next,
  }) = _ReflectionStepModel;

  factory ReflectionStepModel.fromJson(Map<String, Object?> json) => _$ReflectionStepModelFromJson(json);
}
