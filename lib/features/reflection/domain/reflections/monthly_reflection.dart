import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/enums/reflect_type_enum.dart';
import 'package:ruminate/features/reflection/data/model/reflection_model.dart';
import 'package:ruminate/features/reflection/data/model/reflection_step_model.dart';

class MonthlyReflection extends ReflectionModel {
  MonthlyReflection()
    : super(
        title: "Ежемесячная рефлексия",
        description:
            "Универсальная рефлексия, которую рекомендуется выполнять каждый месяц. Содержит достаточно глубокие и необходимые вопросы для самокопаний",
        type: ReflectType.month,
        steps: _createSteps(),
      );

  static List<ReflectionStepModel> _createSteps() {
    final steps = [
      ReflectionStepModel(
        title: "Картина месяца",
        description: "",
        questions: [
          "Насколько я доволен этим месяцем?",
          "Каким словом можно лучше всего описать этот месяц? (Марафон, штиль и пр.)",
          "Какой самый яркий момент этого месяца?",
        ],
      ),
      ReflectionStepModel(
        title: "Достижения и рост",
        description: "Топ 3 самых ценных результата этого месяца",
        questions: [
          "3 место",
          "2 место",
          "1 место",
          "В чем я стал(а) лучше как специалист?",
          "Какое маленькое, но действующее решение я внедрил(а)?",
          "Что я сделал(а) впервые за долгое время или впервые?",
        ],
      ),
      ReflectionStepModel(
        title: "Инсайты и осознания",
        description: "",
        questions: [
          "Что нового ты узнал(а) о себе?",
          "Какое мое убеждение оказалось ложным или ограничивающим?",
          "О чем я раньше не задумывался, но теперь понимаю?",
          "В какой ситуации я повел(а) себя по-новому, не как обычно?",
        ],
      ),
      ReflectionStepModel(
        title: "Баланс и энергия",
        description: "",
        questions: [
          "Топ 3 самых ценных результата этого месяца",
          "Что было главным энергетическим вампиром?",
          "Насколько гармонично было распределено время между работой, отдыхом, развитием?",
          "Какой тип отдыха восстанавливал меня лучше всего?",
        ],
      ),
      ReflectionStepModel(
        title: "Отношения и влияние",
        description: "",
        questions: [
          "Какой тип отдыха восстанавливал меня лучше всего?",
          "Кому я был особенно благодарен и за что?",
          "В чем я стал лучше как партнер/друг/коллега?",
          "Чье мнение или совет оказали наибольшее влияние?",
        ],
      ),
      ReflectionStepModel(
        title: "Фокус и приоритеты",
        description: "",
        questions: [
          "На что ушло непропорционально много времени относительно ценности?",
          "Какой самый важный навык я развивал в этом месяце?",
          "Какая задача оказалась самой сложной, но необходимой?",
          "Что я делегировал/отложил и правильным ли было это решение?",
        ],
      ),
      ReflectionStepModel(
        title: "Будущее и намерения",
        description: "",
        questions: [
          "Главный приоритет следующего месяца (один!)",
          "Что я начну делать по-другому?",
          "От какой привычки/действия я откажусь?",
          "Какой первый шаг я сделаю в новом месяце?",
          "Прочее | Пиши сюда всё что хочешь",
        ],
      ),
    ];

    return steps;
  }
}

final monthlyProvider = Provider<ReflectionModel>((ref) => MonthlyReflection());
