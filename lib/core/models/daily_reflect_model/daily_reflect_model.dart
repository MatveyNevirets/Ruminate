import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ruminate/core/enums/reflect_type_enum.dart';

part 'daily_reflect_model.freezed.dart';
part 'daily_reflect_model.g.dart';

@freezed
abstract class DailyReflectModel with _$DailyReflectModel {
  const factory DailyReflectModel({
    required String id,
    required ReflectType type,
    required Map<String, String> fields,
  }) = _DailyReflectModel;

  factory DailyReflectModel.fromJson(Map<String, Object?> json) => _$DailyReflectModelFromJson(json);
}
