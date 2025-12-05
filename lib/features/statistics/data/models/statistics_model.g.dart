// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticsModel _$StatisticsModelFromJson(Map<String, dynamic> json) =>
    StatisticsModel(
      date: DateTime.parse(json['date'] as String),
      totalReflections: (json['totalReflections'] as num).toInt(),
      totalVictories: (json['totalVictories'] as num).toInt(),
      energyGenerators: json['energyGenerators'] as String?,
      energyKillers: json['energyKillers'] as String?,
      importantToWork: json['importantToWork'] as String?,
      fears: json['fears'] as String?,
    );

Map<String, dynamic> _$StatisticsModelToJson(StatisticsModel instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'totalReflections': instance.totalReflections,
      'totalVictories': instance.totalVictories,
      'energyGenerators': instance.energyGenerators,
      'energyKillers': instance.energyKillers,
      'importantToWork': instance.importantToWork,
      'fears': instance.fears,
    };
