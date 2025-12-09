import 'package:freezed_annotation/freezed_annotation.dart';

part 'statistics_model.freezed.dart';
part 'statistics_model.g.dart';

@freezed
@JsonSerializable()
class StatisticsModel with _$StatisticsModel {
  const StatisticsModel({
    required this.date,
    required this.totalReflections,
    required this.totalVictories,
    required this.energyGenerators,
    required this.energyKillers,
    required this.importantToWork,
    required this.fears,
  });

  @override
  final DateTime date;

  @override
  final int totalReflections;

  @override
  final int totalVictories;

  @override
  final String? energyGenerators;

  @override
  final String? energyKillers;

  @override
  final String? importantToWork;

  @override
  final String? fears;

  factory StatisticsModel.fromJson(Map<String, Object?> json) =>
      _$StatisticsModelFromJson(json);

  Map<String, Object?> toJson() => _$StatisticsModelToJson(this);
}
