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
      energyGenerators: (json['energyGenerators'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      energyKillers: (json['energyKillers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      importantToWork: (json['importantToWork'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      fears: (json['fears'] as List<dynamic>).map((e) => e as String).toList(),
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
