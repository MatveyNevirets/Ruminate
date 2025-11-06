import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ReflectionStepModel {
  final String title;
  final String description;
  final List<Map<String, String?>> questionsAndAnswers;

  ReflectionStepModel? prev;
  ReflectionStepModel? next;

  ReflectionStepModel({
    required this.title,
    required this.description,
    required this.questionsAndAnswers,
    this.prev,
    this.next,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'title': title, 'description': description, 'questionsAndAnswers': questionsAndAnswers};
  }

  String toJson() => json.encode(toMap());

  factory ReflectionStepModel.fromJson(String source) =>
      ReflectionStepModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory ReflectionStepModel.fromMap(Map<String, dynamic> map) {
    final questionsAndAnswersList = (map['questionsAndAnswers'] as List<dynamic>? ?? []);

    final List<Map<String, String?>> convertedQuestionsAndAnswers = [];

    for (final item in questionsAndAnswersList) {
      if (item is Map<String, dynamic>) {
        final convertedMap = <String, String?>{};
        item.forEach((key, value) {
          convertedMap[key] = value?.toString();
        });
        convertedQuestionsAndAnswers.add(convertedMap);
      }
    }

    return ReflectionStepModel(
      title: map['title'] as String,
      description: map['description'] as String,
      questionsAndAnswers: convertedQuestionsAndAnswers,
    );
  }

  ReflectionStepModel copyWith({String? title, String? description, List<Map<String, String?>>? questionsAndAnswers}) {
    return ReflectionStepModel(
      title: title ?? this.title,
      description: description ?? this.description,
      questionsAndAnswers: questionsAndAnswers ?? this.questionsAndAnswers,
    );
  }
}
