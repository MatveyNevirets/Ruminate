// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_reflect_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyReflectModel _$DailyReflectModelFromJson(Map<String, dynamic> json) =>
    _DailyReflectModel(
      id: json['id'] as String,
      type: $enumDecode(_$ReflectTypeEnumMap, json['type']),
      fields: Map<String, String>.from(json['fields'] as Map),
    );

Map<String, dynamic> _$DailyReflectModelToJson(_DailyReflectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ReflectTypeEnumMap[instance.type]!,
      'fields': instance.fields,
    };

const _$ReflectTypeEnumMap = {
  ReflectType.dailySuperficital: 'dailySuperficital',
  ReflectType.dailyIndepth: 'dailyIndepth',
  ReflectType.weekly: 'weekly',
  ReflectType.monthly: 'month',
  ReflectType.year: 'year',
};
