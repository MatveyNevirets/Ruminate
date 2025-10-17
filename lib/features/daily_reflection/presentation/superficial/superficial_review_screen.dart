import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/core/widgets/app_text_field.dart';

class SuperficialReviewScreen extends StatelessWidget {
  const SuperficialReviewScreen({super.key});

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
                "Обзор дня",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(height: Theme.of(context).extraLargePaddingDouble),
              Text(
                "Как я могу описать день в одном предложении?",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(height: Theme.of(context).mediumPaddingDouble),
              AppTextField(),
              SizedBox(height: Theme.of(context).extraLargePaddingDouble),
              Text(
                "Какие эмоции сопровождали этот день?",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(height: Theme.of(context).mediumPaddingDouble),
              AppTextField(),
              SizedBox(height: Theme.of(context).extraLargePaddingDouble),
              Text(
                "Что сегодня запомнилось больше всего?",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(height: Theme.of(context).mediumPaddingDouble),
              AppTextField(),
              SizedBox(height: Theme.of(context).extraLargePaddingDouble),
              AppButton(
                onClick: () => context.go("/home/daily_reflection/superficial_reflection/wins/"),
                text: "Пропустить",
              ),
              SizedBox(height: Theme.of(context).mediumPaddingDouble),
              AppButton(
                onClick: () => context.go("/home/daily_reflection/superficial_reflection/wins/"),
                text: "Далее",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
