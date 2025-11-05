import 'package:ruminate/core/enums/reflect_type_enum.dart';
import 'package:ruminate/core/data/model/reflection_model.dart';
import 'package:ruminate/core/data/model/reflection_step_model.dart';

class MonthlyReflection extends ReflectionModel {
  MonthlyReflection()
    : super(
        title: "Ежемесячная рефлексия",
        description:
            "Универсальная рефлексия, которую рекомендуется выполнять каждый месяц. Содержит достаточно глубокие и необходимые вопросы для самокопаний",
        type: ReflectType.monthly,
        steps: _createStepsLinks(),
      );

  static List<ReflectionStepModel> _createStepsLinks() {
  final steps = [
    ReflectionStepModel(
      title: "Картина месяца",
      description: "",
      questionsAndAnswers: [
        {"Насколько я доволен этим месяцем?": null},
        {"Каким словом можно лучше всего описать этот месяц? (Марафон, штиль и пр.)": null},
        {"Какой самый яркий момент этого месяца?": null},
      ],
    ),
    ReflectionStepModel(
      title: "Достижения и рост",
      description: "Топ 3 самых ценных результата этого месяца",
      questionsAndAnswers: [
        {"3 место": null},
        {"2 место": null},
        {"1 место": null},
        {"В чем я стал(а) лучше как специалист?": null},
        {"Какое маленькое, но действующее решение я внедрил(а)?": null},
        {"Что я сделал(а) впервые за долгое время или впервые?": null},
      ],
    ),
    ReflectionStepModel(
      title: "Инсайты и осознания",
      description: "",
      questionsAndAnswers: [
        {"Что нового ты узнал(а) о себе?": null},
        {"Какое мое убеждение оказалось ложным или ограничивающим?": null},
        {"О чем я раньше не задумывался, но теперь понимаю?": null},
        {"В какой ситуации я повел(а) себя по-новому, не как обычно?": null},
      ],
    ),
    ReflectionStepModel(
      title: "Баланс и энергия",
      description: "",
      questionsAndAnswers: [
        {"Что давало мне больше всего энергии?": null},
        {"Что было главным энергетическим вампиром?": null},
        {"Насколько гармонично было распределено время между работой, отдыхом, развитием?": null},
        {"Какой тип отдыха восстанавливал меня лучше всего?": null},
      ],
    ),
    ReflectionStepModel(
      title: "Отношения и влияние",
      description: "",
      questionsAndAnswers: [
        {"Кому я был особенно благодарен и за что?": null},
        {"В чем я стал лучше как партнер/друг/коллега?": null},
        {"Чье мнение или совет оказали наибольшее влияние?": null},
      ],
    ),
    ReflectionStepModel(
      title: "Фокус и приоритеты",
      description: "",
      questionsAndAnswers: [
        {"На что ушло непропорционально много времени относительно ценности?": null},
        {"Какой самый важный навык я развивал в этом месяце?": null},
        {"Какая задача оказалась самой сложной, но необходимой?": null},
        {"Что я делегировал/отложил и правильным ли было это решение?": null},
      ],
    ),
    ReflectionStepModel(
      title: "Будущее и намерения",
      description: "",
      questionsAndAnswers: [
        {"Главный приоритет следующего месяца (один!)": null},
        {"Что я начну делать по-другому?": null},
        {"От какой привычки/действия я откажусь?": null},
        {"Какой первый шаг я сделаю в новом месяце?": null},
        {"Прочее | Пиши сюда всё что хочешь": null},
      ],
    ),
  ];

  return steps;
}
}
