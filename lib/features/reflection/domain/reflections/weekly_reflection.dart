import 'package:ruminate/core/data/model/reflection_model.dart';
import 'package:ruminate/core/data/model/reflection_step_model.dart';
import 'package:ruminate/core/enums/reflect_type_enum.dart';

class WeeklyReflection extends ReflectionModel {
  WeeklyReflection()
    : super(
        title: "Недельная рефлексия",
        reflectionDate: DateTime.now(),
        description:
            "Еженедельный обзор достижений, уроков и приоритетов. Помогает скорректировать курс и сохранить фокус на главном",
        type: ReflectType.weekly,
        steps: _createStepsLinks(),
      );

  static List<ReflectionStepModel> _createStepsLinks() {
    final steps = [
      ReflectionStepModel(
        title: "Общая картина недели",
        description: "",
        questionsAndAnswers: [
          {"Каким одним словом можно описать эту неделю?": null},
          {"Насколько я доволен неделей по шкале 1-10? Почему именно так?": null},
          {"Какой момент недели был самым ярким?": null},
          {"Что из запланированного удалось выполнить полностью?": null},
        ],
      ),
      ReflectionStepModel(
        title: "Достижения и результаты",
        description: "Топ-3 самых важных победы этой недели",
        questionsAndAnswers: [
          {"Победа номер 1": null},
          {"Победа номер 2": null},
          {"Победа номер 3": null},
          {"Какая задача потребовала больше всего усилий, но была выполнена?": null},
          {"В чем я стал немного лучше, чем на прошлой неделе?": null},
          {"Что я сделал для движения к долгосрочным целям?": null},
        ],
      ),
      ReflectionStepModel(
        title: "Вызовы и инсайты",
        description: "",
        questionsAndAnswers: [
          {"С каким главным вызовом я столкнулся на этой неделе?": null},
          {"Какой урок я извлек из этой ситуации?": null},
          {"В какой момент я чувствовал наибольшее напряжение?": null},
          {"Что я понял о своих рабочих привычках?": null},
        ],
      ),
      ReflectionStepModel(
        title: "Энергия и восстановление",
        description: "",
        questionsAndAnswers: [
          {"В какие дни я чувствовал наибольший прилив энергии?": null},
          {"Что помогало мне восстанавливаться после сложных задач?": null},
          {"Какой тип отдыха был самым эффективным?": null},
          {"Насколько сбалансированно я распределял работу и отдых?": null},
        ],
      ),
      ReflectionStepModel(
        title: "Фокус и продуктивность",
        description: "",
        questionsAndAnswers: [
          {"На что ушло непропорционально много времени?": null},
          {"В какие моменты я был наиболее сфокусирован?": null},
          {"Какие отвлечения мешали больше всего?": null},
          {"Какую одну привычку хочу улучшить на следующей неделе?": null},
        ],
      ),
      ReflectionStepModel(
        title: "Приоритеты на следующую неделю",
        description: "",
        questionsAndAnswers: [
          {"Главный приоритет следующей недели (один!)": null},
          {"Какие 3 ключевые задачи должны быть выполнены?": null},
          {"Что я буду делать по-другому?": null},
          {"Какой первый шаг я сделаю в понедельник?": null},
          {"Прочее | Пиши сюда всё что хочешь": null},
        ],
      ),
    ];

    return steps;
  }
}
