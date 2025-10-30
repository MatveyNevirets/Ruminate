import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/enums/reflect_type_enum.dart';
import 'package:ruminate/features/reflection/data/model/reflection_model.dart';
import 'package:ruminate/features/reflection/data/model/reflection_step_model.dart';

class DailyIndepthReflection extends ReflectionModel {
  DailyIndepthReflection()
    : super(
        title: "Ежедневная глубокая рефлексия",
        description: "Глубокая рефлексия включает в себя 30 вопросов. Позволит закопаться глубоко в недры дня",
        type: ReflectType.dailyIndepth,
        steps: _createStepsLinks(),
      );

  static List<ReflectionStepModel> _createStepsLinks() {
    final steps = [
      ReflectionStepModel(
        title: "Итоги дня",
        description: "",
        questions: ["Как я могу описать день в одном предложении?", "Какие 2-3 эмоции сопровождали этот день?"],
      ),
      ReflectionStepModel(
        title: "Тело и энергия",
        description: "",
        questions: [
          "Какой уровень энергии у меня сейчас по шкале от 1 до 10?",
          "Где в теле я сейчас чувствую напряжение или комфорт?",
        ],
      ),
      ReflectionStepModel(
        title: "Победы дня",
        description: "Напиши 3 главные победы дня",
        questions: [
          'Победа 1',
          "Победа 2",
          "Победа 3",
          "Что мне помогало сегодня? (Привычка, человек, обстоятельство)",
        ],
      ),
      ReflectionStepModel(
        title: "Работа со сложностями",
        description: "",
        questions: [
          "Что я боюсь принять или изменить в своей жизни?",
          "Почему ты боишься это изменить или приянть?",
          "Какая ситуация для тебя была сегодня самой тяжелой? Что произошло?",
          "Как ты считаешь, какая эмоция, убеждение или твое действие могло запустить это? Почему это произошло?",
          "Какие эмоции и действия ты заметил(а) у себя после того, как это случилось?",
          "Была ли подобная реакция у тебя раньше? Если да, опиши подобные ситуации",
        ],
      ),
      ReflectionStepModel(
        title: "Действия | Эксперимент",
        description: "",
        questions: [
          "Какой самый важный урок-инсайт ты можешь извлечь из сегодняшнего дня?",
          "Какой один конкретный шаг я попробую завтра днем? (Что это будет? Когда? Как долго? Как ты поймешь, что его выполнил(а)?)",
          "Если твоя сложная ситуация повториться, то какая желаемая реакция или правило будет действовать на тебя?",
        ],
      ),
      ReflectionStepModel(
        title: "Благодарность",
        description: "",
        questions: [
          "За что я благодарен(на) сегодняшнему дню? (1-3 пункта, даже самых незначительных)",
          "Что из сегодняшнего дня я хочу сохранить или повторить в будущем?",
          "Прочее | Пиши сюда всё что угодно",
        ],
      ),
    ];

    return steps;
  }
}


final dailyIndepthProvider = Provider<ReflectionModel>((ref) => DailyIndepthReflection());
