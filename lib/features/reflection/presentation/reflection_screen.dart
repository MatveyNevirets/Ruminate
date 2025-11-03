import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/core/widgets/app_text_field.dart';
import 'package:ruminate/features/reflection/data/datasources/local_reflection_datasource/local_reflection_datasource.dart';
import 'package:ruminate/features/reflection/domain/reflections/monthly_reflection.dart';
import 'package:ruminate/features/reflection/presentation/view_model/reflection_view_model.dart';

class ReflectionScreen extends ConsumerWidget {
  ReflectionScreen({super.key});

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(reflectionVM.notifier);
    final currentStep = ref.watch(reflectionVM);

    final localS = ref.watch(localStorage);
    localS.readAllReflectionsFromDirectory();

    return Scaffold(
      appBar: createAppBar(context),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: Theme.of(context).largePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentStep?.title ?? "Что-то пошло не так",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              SizedBox(height: Theme.of(context).extraLargePaddingDouble),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: currentStep?.questions.length ?? 0,
                itemBuilder: (context, index) => _CreateQuestion(title: currentStep?.questions[index]),
              ),
              SizedBox(height: Theme.of(context).extraLargePaddingDouble),
              AppButton(
                onClick: () {
                  viewModel.prevStep();
                  scrollController.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
                },
                text: "Пропустить",
              ),
              SizedBox(height: Theme.of(context).mediumPaddingDouble),
              AppButton(
                onClick: () {
                  viewModel.nextStep();
                  scrollController.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
                },
                text: "Далее",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _CreateQuestion extends StatelessWidget {
  String? title;

  _CreateQuestion({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Theme.of(context).largePaddingDouble),
        Text(
          title ?? "Что-то пошло не так",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        SizedBox(height: Theme.of(context).mediumPaddingDouble),
        AppTextField(),
        SizedBox(height: Theme.of(context).largePaddingDouble),
      ],
    );
  }
}
