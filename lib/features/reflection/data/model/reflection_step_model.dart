class ReflectionStepModel {
  final String title;
  final String description;
  final List<String> questions;

  ReflectionStepModel? prev;
  ReflectionStepModel? next;

  ReflectionStepModel({required this.title, required this.description, required this.questions, this.prev, this.next});
}
