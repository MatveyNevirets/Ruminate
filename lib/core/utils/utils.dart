import 'package:ruminate/core/data/model/reflection_model.dart';

abstract class Utils {
  static String cutStringByChars(String string, int maxLength) {
    if (string.length > maxLength) {
      return "${string.substring(0, maxLength)}...";
    } else {
      return string;
    }
  }

  static List<int> convertStringsAsInt(List<String> strings) {
    final List<int> intList = [];

    for (String string in strings) {
      intList.add(int.tryParse(string) ?? 0);
    }

    return intList;
  }

  static List<String> getWeekdaysAsString() {
    final currentDay = DateTime.now().day;
    final currentWeekday = DateTime.now().weekday - 1;

    List<String> weekdayList = [];

    for (int i = currentWeekday; i > 0; i--) {
      weekdayList.add((currentDay - i).toString());
    }
    for (int i = 0; i < 7 - currentWeekday; i++) {
      weekdayList.add((currentDay + i).toString());
    }

    return weekdayList;
  }

  static String fetchDateFromReflection(ReflectionModel reflection) {
    final day =
        reflection.reflectionDate?.day.toString().padLeft(2, '0') ?? "DD";
    final month =
        reflection.reflectionDate?.month.toString().padLeft(2, '0') ?? "MM";
    final year =
        reflection.reflectionDate?.year.toString().padLeft(2, '0') ?? "YYYY";

    final result = "$day.$month.$year";
    return result;
  }

  static String fetchTextDateFromReflection(ReflectionModel reflection) {
    final nowDate = DateTime.now();
    final reflectionDate = reflection.reflectionDate;

    if (reflectionDate == null) "Что-то пошло не так :(";

    final daysDifference = nowDate.difference(reflectionDate!).inDays.abs();

    if (daysDifference == 0) {
      return "Сегодня";
    } else if (daysDifference == 1) {
      return "Вчера";
    } else if (daysDifference == 2) {
      return "Позавчера";
    } else if (daysDifference == 3) {
      return "Три дня назад";
    } else if (daysDifference == 4) {
      return "Четыре дня назад";
    } else if (daysDifference == 5) {
      return "Пять дней назад";
    } else if (daysDifference == 6) {
      return "Шесть дней назад";
    } else if (daysDifference > 3 && daysDifference < 13) {
      return "Неделю назад";
    } else if (daysDifference > 13 && daysDifference < 30) {
      return "Месяц назад";
    } else if (daysDifference > 31 && daysDifference < 60) {
      return "Два месяца назад";
    } else if (daysDifference > 61 && daysDifference < 90) {
      return "Три месяца назад";
    } else if (daysDifference > 180 && daysDifference < 365) {
      return "Пол года назад";
    } else if (daysDifference > 366 && daysDifference < 730) {
      return "Более года назад";
    } else if (daysDifference > 1825 && daysDifference < 3650) {
      return "Более пяти лет назад";
    } else if (daysDifference > 3651) {
      return "Более десяти лет назад";
    }
    return "Некоторое время назад";
  }
}
