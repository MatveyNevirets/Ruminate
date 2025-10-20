import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/core/widgets/app_text_field.dart';

class IndepthReloadScreen extends StatelessWidget {
  const IndepthReloadScreen({super.key});

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
                "Восстановление | Личные границы",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(height: Theme.of(context).extraLargePaddingDouble),
              Text(
                "Что мне нужно сделать прямо сейчас или чуть позже, чтобы восстановиться? (Если позже, то когда?)",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(height: Theme.of(context).mediumPaddingDouble),
              AppTextField(),
              SizedBox(height: Theme.of(context).extraLargePaddingDouble),
              Text(
                "Нарушил(а) ли я сегодня свои границы? Если да, то как этого избежать в будущем?",
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
