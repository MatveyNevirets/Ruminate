import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/core/widgets/app_text_field.dart';
import 'package:ruminate/features/reflection/presentation/view_model/reflection_view_model.dart';

class ReflectionScreen extends ConsumerWidget {
  const ReflectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStepVM = ref.watch(dailySuperficialReflectionVM.notifier);
    final currentStep = ref.watch(dailySuperficialReflectionVM);

    return Scaffold(
      appBar: createAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: Theme.of(context).largePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Итоги дня | ${currentStep?.title}",
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
              AppButton(onClick: () => currentStepVM.nextStep(), text: "Пропустить"),
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
