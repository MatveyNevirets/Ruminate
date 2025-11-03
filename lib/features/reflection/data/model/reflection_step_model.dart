import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ReflectionStepModel {
  final String title;
  final String description;
  final List<String> questions;

  ReflectionStepModel? prev;
  ReflectionStepModel? next;

  ReflectionStepModel({required this.title, required this.description, required this.questions, this.prev, this.next});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{'title': title, 'description': description, 'questions': questions};
  }

  factory ReflectionStepModel.fromMap(Map<String, dynamic> map) {
    return ReflectionStepModel(
      title: map['title'] as String,
      description: map['description'] as String,
      questions: List<String>.from((map['questions'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReflectionStepModel.fromJson(String source) =>
      ReflectionStepModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
