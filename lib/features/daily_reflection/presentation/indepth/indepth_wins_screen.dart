import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/core/widgets/app_text_field.dart';

class IndepthWinsScreen extends StatelessWidget {
  const IndepthWinsScreen({super.key});

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
                "Победы дня",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(height: Theme.of(context).extraLargePaddingDouble),
              Text(
                "Напиши 3 главные победы дня",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(height: Theme.of(context).largePaddingDouble),
              Text(
                "Победа 1",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),

              AppTextField(),
              SizedBox(height: Theme.of(context).largePaddingDouble),
              Text(
                "Победа 2",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),

              AppTextField(),
              SizedBox(height: Theme.of(context).largePaddingDouble),
              Text(
                "Победа 3",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              AppTextField(),
              SizedBox(height: Theme.of(context).extraLargePaddingDouble),
              Text(
                "Что мне помагало сегодня? (Привычка, человек, обстоятельство)",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(height: Theme.of(context).mediumPaddingDouble),
              AppTextField(),

              SizedBox(height: Theme.of(context).extraLargePaddingDouble),
              AppButton(
                onClick: () => context.go("/home/daily_reflection/indepth_reflection/energy/wins/difficults/"),
                text: "Пропустить",
              ),
              SizedBox(height: Theme.of(context).mediumPaddingDouble),
              AppButton(
                onClick: () => context.go("/home/daily_reflection/indepth_reflection/energy/wins/difficults/"),
                text: "Далее",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
