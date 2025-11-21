import 'package:ruminate/core/enums/reflect_type_enum.dart';
import 'package:ruminate/core/data/model/reflection_model.dart';
import 'package:ruminate/core/data/model/reflection_step_model.dart';

class DailyIndepthReflection extends ReflectionModel {
  DailyIndepthReflection()
    : super(
        title: "Ежедневная глубокая рефлексия",      reflectionDate: DateTime.now(),
        description: "Глубокая рефлексия включает в себя 30 вопросов. Позволит закопаться глубоко в недры дня",
        type: ReflectType.dailyIndepth,
        steps: _createStepsLinks(),
      );

  static List<ReflectionStepModel> _createStepsLinks() {
  final steps = [
    ReflectionStepModel(
      title: "Итоги дня",
      description: "",
      questionsAndAnswers: [
        {"Как я могу описать день в одном предложении?": null},
        {"Какие 2-3 эмоции сопровождали этот день?": null},
      ],
    ),
    ReflectionStepModel(
      title: "Тело и энергия",
      description: "",
      questionsAndAnswers: [
        {"Какой уровень энергии у меня сейчас по шкале от 1 до 10?": null},
        {"Где в теле я сейчас чувствую напряжение или комфорт?": null},
      ],
    ),
    ReflectionStepModel(
      title: "Победы дня",
      description: "Напиши 3 главные победы дня",
      questionsAndAnswers: [
        {"Победа 1": null},
        {"Победа 2": null},
        {"Победа 3": null},
        {"Что мне помогало сегодня? (Привычка, человек, обстоятельство)": null},
      ],
    ),
    ReflectionStepModel(
      title: "Работа со сложностями",
      description: "",
      questionsAndAnswers: [
        {"Что я боюсь принять или изменить в своей жизни?": null},
        {"Почему ты боишься это изменить или принять?": null},
        {"Какая ситуация для тебя была сегодня самой тяжелой? Что произошло?": null},
        {"Как ты считаешь, какая эмоция, убеждение или твое действие могло запустить это? Почему это произошло?": null},
        {"Какие эмоции и действия ты заметил(а) у себя после того, как это случилось?": null},
        {"Была ли подобная реакция у тебя раньше? Если да, опиши подобные ситуации": null},
      ],
    ),
    ReflectionStepModel(
      title: "Действия | Эксперимент",
      description: "",
      questionsAndAnswers: [
        {"Какой самый важный урок-инсайт ты можешь извлечь из сегодняшнего дня?": null},
        {"Какой один конкретный шаг я попробую завтра днем? (Что это будет? Когда? Как долго? Как ты поймешь, что его выполнил(а)?)": null},
        {"Если твоя сложная ситуация повториться, то какая желаемая реакция или правило будет действовать на тебя?": null},
      ],
    ),
    ReflectionStepModel(
      title: "Благодарность",
      description: "",
      questionsAndAnswers: [
        {"За что я благодарен(на) сегодняшнему дню? (1-3 пункта, даже самых незначительных)": null},
        {"Что из сегодняшнего дня я хочу сохранить или повторить в будущем?": null},
        {"Прочее | Пиши сюда всё что угодно": null},
      ],
    ),
  ];

  return steps;
}
}

