import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/core/widgets/app_text_field.dart';

class MonthReflectionScreen extends StatelessWidget {
  const MonthReflectionScreen({super.key});

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
                "Благодарность",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(height: Theme.of(context).extraLargePaddingDouble),
              Text(
                "За что я благодарен(на) сегодня? (1-3 пункта)",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(height: Theme.of(context).mediumPaddingDouble),
              AppTextField(),
              SizedBox(height: Theme.of(context).extraLargePaddingDouble),
              Text(
                "Что из сегодняшнего дня я хочу сохранить или повторить в будущем?",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(height: Theme.of(context).mediumPaddingDouble),
              AppTextField(),

              SizedBox(height: Theme.of(context).extraLargePaddingDouble),
              AppButton(onClick: () => context.go("/home"), text: "Пропустить"),
              SizedBox(height: Theme.of(context).mediumPaddingDouble),
              AppButton(onClick: () => context.go("/home"), text: "Далее"),
            ],
          ),
        ),
      ),
    );
  }
}
