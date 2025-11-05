import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        questionsAndAnswers: [
          {"Как я могу описать день в одном предложении?": null},
          {"Какие эмоции сопровождали этот день?": null},
          {"Что мне сегодня запомнилось больше всего?": null},
        ],
      ),
      ReflectionStepModel(
        title: "Победы дня",
        description: "Напиши 3 главные победы",
        questionsAndAnswers: [
          {"Победа 1": null},
          {"Победа 2": null},
          {"Победа 3": null},
          {"За что я благодарен сегодняшнему дню?": null},
          {"Что сработало хорошо, помогло, дало ресурс?": null},
        ],
      ),
      ReflectionStepModel(
        title: "Рост | Сложности",
        description: "",
        questionsAndAnswers: [
          {"Что не получилось или было сложно?": null},
          {"Что можно было бы изменить, если бы ты знал(а) это заранее?": null},
        ],
      ),
      ReflectionStepModel(
        title: "Внутреннее состояние",
        description: "",
        questionsAndAnswers: [
          {"Как я чувствую себя физически в теле?": null},
          {"Прочее | Пиши сюда что хочешь": null},
        ],
      ),
    ];

    return steps;
  }
}