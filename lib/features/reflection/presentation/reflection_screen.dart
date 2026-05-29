import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/reflection/data/model/reflection_step_model.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/core/widgets/app_text_field.dart';
import 'package:ruminate/features/reflection/presentation/providers/reflection_view_model_provider.dart';

class ReflectionScreen extends ConsumerStatefulWidget {
  const ReflectionScreen({super.key});

  @override
  ConsumerState<ReflectionScreen> createState() => _ReflectionScreenState();
}

class _ReflectionScreenState extends ConsumerState<ReflectionScreen> {
  final ScrollController scrollController = ScrollController();
  final Map<int, TextEditingController> _controllers = {};

  @override
  void dispose() {
    scrollController.dispose();
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  List<TextEditingController> _controllersForStep(ReflectionStepModel? step) {
    final count = step?.questionsAndAnswers.length ?? 0;

    for (final key in _controllers.keys.toList()) {
      if (key >= count) {
        _controllers[key]?.dispose();
        _controllers.remove(key);
      }
    }

    for (int i = 0; i < count; i++) {
      _controllers.putIfAbsent(i, () => TextEditingController());
    }

    return List.generate(count, (index) => _controllers[index]!);
  }

  void _scrollToTop() {
    if (!scrollController.hasClients) return;

    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final reflectionViewModel = ref.watch(reflectionVM.notifier);
    final currentStep = ref.watch(reflectionVM);
    final controllers = _controllersForStep(currentStep);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: -120,
            right: -90,
            child: Container(
              width: 300,
              height: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(56),
                color: colorScheme.primary.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            top: 260,
            left: -120,
            child: Container(
              width: 260,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(42),
                color: colorScheme.primary.withOpacity(0.045),
              ),
            ),
          ),
          Positioned(
            bottom: -170,
            right: -90,
            child: Container(
              width: 340,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: colorScheme.primary.withOpacity(0.05),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: theme.largePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HeroCard(
                      title: currentStep?.title ?? "Что-то пошло не так",
                      subtitle:
                          "Заполняй ответы шаг за шагом — спокойно и без спешки.",
                      icon: Icons.mode_edit_outline_rounded,
                    ),
                    SizedBox(height: theme.largePaddingDouble),

                    _SurfaceCard(
                      accent: colorScheme.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Container(
                              height: 54,
                              width: 54,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: colorScheme.primary.withOpacity(0.12),
                              ),
                              child: Icon(
                                Icons.question_answer_rounded,
                                color: colorScheme.primary,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Вопросы этого шага",
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          height: 1.2,
                                        ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "${currentStep?.questionsAndAnswers.length ?? 0} вопросов для осмысления",
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.onSurface.withOpacity(
                                        0.62,
                                      ),
                                      height: 1.45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: theme.extraLargePaddingDouble),
                    _QuestionsWidget(
                      currentStep: currentStep,
                      controllers: controllers,
                    ),
                    SizedBox(height: theme.extraLargePaddingDouble),

                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            onClick: () {
                              reflectionViewModel.prevStep();
                              _scrollToTop();
                            },
                            text: "Назад",
                          ),
                        ),
                        SizedBox(width: theme.mediumPaddingDouble),
                        Expanded(
                          child: AppButton(
                            onClick: () {
                              final answers = controllers
                                  .map((controller) => controller.text)
                                  .toList();

                              reflectionViewModel.nextStep(answers, context);
                              _scrollToTop();
                            },
                            text: "Далее",
                            icon: Icons.arrow_forward_rounded,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: theme.largePaddingDouble),
                  ],
                ),
              ),
            ),
          ),
        ],
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
    final questions = currentStep?.questionsAndAnswers ?? const [];
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (questions.isEmpty) {
      return _SurfaceCard(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            "На этом шаге пока нет вопросов.",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.62),
              height: 1.5,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: questions.length,
      separatorBuilder: (context, index) =>
          SizedBox(height: theme.mediumPaddingDouble),
      itemBuilder: (context, index) => _QuestionCard(
        number: index + 1,
        title: questions[index].keys.first,
        textController: controllers[index],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.number,
    required this.title,
    required this.textController,
  });

  final int number;
  final String title;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _SurfaceCard(
      accent: colorScheme.primary,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: colorScheme.surfaceContainerHighest.withOpacity(0.12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: colorScheme.primary.withOpacity(0.12),
                    border: Border.all(
                      color: colorScheme.primary.withOpacity(0.10),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "$number",
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      height: 1.28,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            AppTextField(
              controller: textController,
              hintText: "Напиши свой ответ...",
              maxLines: 5,
              minLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _SurfaceCard(
      accent: colorScheme.primary,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary.withOpacity(0.11),
              colorScheme.surfaceContainerHighest.withOpacity(0.16),
            ],
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: colorScheme.primary.withOpacity(0.14),
                border: Border.all(
                  color: colorScheme.primary.withOpacity(0.10),
                ),
              ),
              child: Icon(icon, size: 36, color: colorScheme.primary),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.8,
                      height: 1.05,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.64),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SurfaceCard extends StatelessWidget {
  const _SurfaceCard({required this.child, this.accent});

  final Widget child;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final borderColor = (accent ?? colorScheme.onSurface).withOpacity(0.08);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: colorScheme.surface,
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            blurRadius: 26,
            offset: const Offset(0, 12),
            color: Colors.black.withOpacity(0.045),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: child,
        ),
      ),
    );
  }
}
