import 'package:ruminate/core/enums/reflect_type_enum.dart';
import 'package:ruminate/features/reflection/data/model/reflection_model.dart';
import 'package:ruminate/features/reflection/data/model/reflection_step_model.dart';

class DailySuperficialReflection extends ReflectionModel {
  DailySuperficialReflection()
    : super(
        title: "Ежедневная поверхностная рефлексия",
        description:
            "Ежеденевная поверхностная рефлексия отлично подойдет в моменты, когда совершенно нет настроения что либо заполнять. Только самые необходимые вопросы",
        type: ReflectType.dailySuperficital,
        steps: _createStepsLinks(),
      );

  static List<ReflectionStepModel> _createStepsLinks() {
    final steps = [
      ReflectionStepModel(
        title: "Итоги дня",
        description: "",
        questions: [
          "Как я могу описать день в одном предложении?",
          "Какие эмоции сопровождали этот день?",
          "Что мне сегоддня запомнилось больше всего?",
        ],
      ),
      ReflectionStepModel(
        title: "Победы дня",
        description: "Напиши 3 главные победы",
        questions: [
          "Победа 1",
          "Победа 2",
          "Победа 3",
          "За что я благодарен сегодняшнему дню?",
          "Что сработало хорошо, помогло, дало ресурс?",
        ],
      ),
      ReflectionStepModel(
        title: "Рост | Сложности",
        description: "",
        questions: [
          'Что не получилось или было сложно?',
          "Что можно было бы изменить, если бы ты знал(а) это заранее?",
        ],
      ),
      ReflectionStepModel(
        title: "Внуреннее состояние",
        description: "",
        questions: ["Как я чувствую себя физически в теле?", "Прочее | Пиши сюда что хочешь"],
      ),
    ];

    return steps;
  }
}
