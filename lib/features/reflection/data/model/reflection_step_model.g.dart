// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reflection_step_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReflectionStepModel _$ReflectionStepModelFromJson(Map<String, dynamic> json) =>
    _ReflectionStepModel(
      title: json['title'] as String,
      description: json['description'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      prev: json['prev'] == null
          ? null
          : ReflectionStepModel.fromJson(json['prev'] as Map<String, dynamic>),
      next: json['next'] == null
          ? null
          : ReflectionStepModel.fromJson(json['next'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReflectionStepModelToJson(
  _ReflectionStepModel instance,
) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'questions': instance.questions,
  'prev': instance.prev,
  'next': instance.next,
};
