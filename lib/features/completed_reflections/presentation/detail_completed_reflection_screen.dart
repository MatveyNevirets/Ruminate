import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ruminate/core/reflection/data/model/reflection_model.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';

class DetailCompletedReflectionScreen extends StatelessWidget {
  final ReflectionModel reflection;

  const DetailCompletedReflectionScreen({super.key, required this.reflection});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (reflection.steps.isNotEmpty) {
      log(reflection.steps[0].title);
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: -120,
            right: -90,
            child: Container(
              width: 320,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(56),
                color: colorScheme.primary.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            top: 240,
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
            right: -100,
            child: Container(
              width: 360,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(64),
                color: colorScheme.primary.withOpacity(0.05),
              ),
            ),
          ),
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: theme.largePadding.copyWith(top: 8),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _HeroCard(
                          title: reflection.title,
                          subtitle:
                              "Просматривай сохранённую рефлексию по шагам и возвращайся к своим ответам в любой момент.",
                          date: _receiveDataFromReflectionModel(reflection),
                          icon: Icons.library_books_rounded,
                        ),

                        SizedBox(height: theme.largePaddingDouble * 2.15),
                        _SectionTitle(
                          title: "Содержимое",
                          subtitle:
                              "Каждый шаг и каждый ответ собраны ниже в аккуратные карточки.",
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: theme.largePadding.copyWith(top: 18),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final step = reflection.steps[index];

                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: theme.mediumPaddingDouble,
                        ),
                        child: _StepCard(
                          stepIndex: index + 1,
                          title: step.title,
                          qnaWidgets: step.questionsAndAnswers
                              .map((qna) => _QnaCard(qna: qna))
                              .toList(),
                        ),
                      );
                    }, childCount: reflection.steps.length),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(
                    bottom: theme.largePaddingDouble * 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _receiveDataFromReflectionModel(ReflectionModel reflection) {
    final date = reflection.reflectionDate;

    if (date == null) {
      return "Тут пусто";
    }

    return "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}";
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final String date;
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  const SizedBox(height: 16),
                  _MiniChip(text: "Дата: $date", color: colorScheme.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withOpacity(0.60),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.stepIndex,
    required this.title,
    required this.qnaWidgets,
  });

  final int stepIndex;
  final String title;
  final List<Widget> qnaWidgets;

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
          color: colorScheme.surfaceContainerHighest.withOpacity(0.10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: colorScheme.primary.withOpacity(0.12),
                    border: Border.all(
                      color: colorScheme.primary.withOpacity(0.10),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "$stepIndex",
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Вопросы и ответы этого шага",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.60),
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            ...qnaWidgets,
          ],
        ),
      ),
    );
  }
}

class _QnaCard extends StatelessWidget {
  const _QnaCard({required this.qna});

  final Map<String, String?> qna;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final question = qna.keys.first;
    final answer = qna.values.first ?? "Тут пусто";

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
          ),
          SizedBox(height: theme.mediumPaddingDouble),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: colorScheme.surfaceContainerHighest.withOpacity(0.18),
              border: Border.all(
                color: colorScheme.onSurface.withOpacity(0.06),
              ),
            ),
            child: Padding(
              padding: theme.mediumPadding,
              child: Text(
                answer,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.72),
                  height: 1.6,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniChip extends StatelessWidget {
  const _MiniChip({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.10)),
      ),
      child: Text(
        text,
        style: theme.textTheme.labelMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
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
