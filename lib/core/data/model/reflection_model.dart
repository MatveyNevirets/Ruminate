// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ruminate/core/enums/reflect_type_enum.dart';
import 'package:ruminate/core/data/model/reflection_step_model.dart';

class ReflectionModel {
  String title;
  String description;
  ReflectType type;
  List<ReflectionStepModel> steps;

  ReflectionModel({required this.title, required this.description, required this.type, required this.steps});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'type': type.name,
      'steps': steps.map((x) => x.toMap()).toList(),
    };
  }

  factory ReflectionModel.fromMap(Map<String, dynamic> map) {
    return ReflectionModel(
      title: map['title'] as String,
      description: map['description'] as String,
      type: ReflectType.dailyIndepth,
      steps: List<ReflectionStepModel>.from(
        (map['steps'] as List<dynamic>).map<ReflectionStepModel>(
          (x) => ReflectionStepModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReflectionModel.fromJson(String source) =>
      ReflectionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
