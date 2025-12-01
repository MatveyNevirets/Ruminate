import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/data/model/reflection_step_model.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/core/widgets/app_text_field.dart';
import 'package:ruminate/features/reflection/presentation/providers/reflection_view_model_provider.dart';

class ReflectionScreen extends ConsumerWidget {
  ReflectionScreen({super.key});

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reflectionViewModel = ref.watch(reflectionVM.notifier);
    final currentStep = ref.watch(reflectionVM);

    //Generate input field controllers based on their number
    List<TextEditingController> controllers = List.generate(
      currentStep?.questionsAndAnswers.length ?? 0,
      (int index) => TextEditingController(),
    );

    return Scaffold(
      appBar: createAppBar(context),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: Theme.of(context).largePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TitleWidget(currentStep: currentStep),
              SizedBox(height: Theme.of(context).extraLargePaddingDouble),
              _QuestionsWidget(
                currentStep: currentStep,
                controllers: controllers,
              ),
              SizedBox(height: Theme.of(context).extraLargePaddingDouble),
              AppButton(
                onClick: () {
                  reflectionViewModel.prevStep();
                  scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                  );
                },
                text: "Назад",
              ),
              SizedBox(height: Theme.of(context).mediumPaddingDouble),
              AppButton(
                onClick: () {
                  List<String> answers = [];
                  for (TextEditingController controller in controllers) {
                    answers.add(controller.text);
                  }
                  reflectionViewModel.nextStep(answers, context);
                  scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                  );
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

class _QuestionsWidget extends StatelessWidget {
  const _QuestionsWidget({
    required this.currentStep,
    required this.controllers,
  });

  final ReflectionStepModel? currentStep;
  final List<TextEditingController> controllers;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: currentStep?.questionsAndAnswers.length ?? 0,
      itemBuilder: (context, index) => _CreateQuestion(
        title:
            currentStep?.questionsAndAnswers[index].keys.first ??
            "Что-то пошло не так :(",
        textController: controllers[index],
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({required this.currentStep});

  final ReflectionStepModel? currentStep;

  @override
  Widget build(BuildContext context) {
    return Text(
      currentStep?.title ?? "Что-то пошло не так",
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

// ignore: must_be_immutable
class _CreateQuestion extends StatelessWidget {
  String? title;
  TextEditingController? textController;

  _CreateQuestion({required this.title, required this.textController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Theme.of(context).largePaddingDouble),
        Text(
          title ?? "Что-то пошло не так",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        SizedBox(height: Theme.of(context).mediumPaddingDouble),
        AppTextField(controller: textController),
        SizedBox(height: Theme.of(context).largePaddingDouble),
      ],
    );
  }
}
