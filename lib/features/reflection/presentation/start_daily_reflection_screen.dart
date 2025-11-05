import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_button.dart';

class StartDailyReflectionScreen extends StatelessWidget {
  const StartDailyReflectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(context),
      body: Padding(
        padding: Theme.of(context).largePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Как рефлексируем сегодня?",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(height: Theme.of(context).extraLargePaddingDouble),
            Text(
              "Глубоко",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(height: Theme.of(context).smallPaddingDouble),
            Text(
              "Глубокая рефлексия включает в себя 30 вопросов. Позволит закопаться глубоко в недры дня",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(height: Theme.of(context).largePaddingDouble),
            AppButton(
              onClick: () => context.go("/home/daily_reflection/indepth_reflection/"),
              text: "Глубокое погружение",
            ),
            SizedBox(height: Theme.of(context).extraLargePaddingDouble),
            Text(
              "Поверхностно",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(height: Theme.of(context).smallPaddingDouble),
            Text(
              "Поверхностная рефлексия включает в себя 10 вопросов. Поможет в моменты, когда совершенно ничего не хочется писать",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(height: Theme.of(context).largePaddingDouble),
            AppButton(onClick: () =>  context.go("/home/daily_reflection/superficial_reflection"), text: "Поверхностный обзор")
           ,
          ],
        ),
      ),
    );
  }
}
