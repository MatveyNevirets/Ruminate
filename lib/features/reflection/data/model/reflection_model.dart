// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ruminate/core/enums/reflect_type_enum.dart';
import 'package:ruminate/features/reflection/data/model/reflection_step_model.dart';

class ReflectionModel {
  String title;
  String description;
  ReflectType type;
  List<ReflectionStepModel> steps;
  ReflectionModel({
    required this.title,
    required this.description,
    required this.type,
    required this.steps,
  });
}
