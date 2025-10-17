import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/core/widgets/app_text_field.dart';

class SuperficialGrowScreen extends StatelessWidget {
  const SuperficialGrowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: Theme.of(context).largePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Рост | Сложности",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(height: Theme.of(context).extraLargePaddingDouble),

              Text(
                "Что не получилось или было сложно?",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(height: Theme.of(context).mediumPaddingDouble),
              AppTextField(),
              SizedBox(height: Theme.of(context).extraLargePaddingDouble),
              Text(
                "Что можно было бы изменить, если бы ты знал(а) это заранее?",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(height: Theme.of(context).mediumPaddingDouble),
              AppTextField(),
              SizedBox(height: Theme.of(context).extraLargePaddingDouble),
              AppButton(onClick: () => context.go("/home/daily_reflection/superficial_reflection/wins/grow/state/"), text: "Пропустить"),
              SizedBox(height: Theme.of(context).mediumPaddingDouble),
              AppButton(onClick: () => context.go("/home/daily_reflection/superficial_reflection/wins/grow/state"), text: "Далее"),
            ],
          ),
        ),
      ),
    );
  }
}
