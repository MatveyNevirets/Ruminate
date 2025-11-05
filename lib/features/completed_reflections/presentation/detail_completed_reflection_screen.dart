import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ruminate/core/data/model/reflection_model.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';

class DetailCompletedReflectionScreen extends StatelessWidget {
  final ReflectionModel reflection;
  const DetailCompletedReflectionScreen({super.key, required this.reflection});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    log(reflection.steps[0].title);
    return Scaffold(
      appBar: createAppBar(context),
      body: Padding(
        padding: Theme.of(context).largePadding,
        child: CustomScrollView(
          slivers: [
            _TitleWidget(reflection: reflection, theme: theme),
            SliverToBoxAdapter(child: SizedBox(height: theme.mediumPaddingDouble)),
            _SeparatorWidget(theme: theme),
            SliverToBoxAdapter(child: SizedBox(height: theme.mediumPaddingDouble)),
            _DescriptionWidget(reflection: reflection, theme: theme),
            SliverToBoxAdapter(child: SizedBox(height: theme.largePaddingDouble)),
            _ReflectionDataWidget(reflection: reflection, theme: theme),
          ],
        ),
      ),
    );
  }
}

class _ReflectionDataWidget extends StatelessWidget {
  const _ReflectionDataWidget({super.key, required this.reflection, required this.theme});

  final ReflectionModel reflection;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TitleStepWidget(reflection: reflection, theme: theme, index: index),
            SizedBox(height: theme.mediumPaddingDouble),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: reflection.steps[index].questionsAndAnswers
                  .map((qna) => _QNAWidget(theme: theme, qna: qna))
                  .toList(),
            ),
          ],
        );
      }, childCount: reflection.steps.length),
    );
  }
}

class _TitleStepWidget extends StatelessWidget {
  final int index;
  const _TitleStepWidget({super.key, required this.reflection, required this.theme, required this.index});

  final ReflectionModel reflection;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Text(
      reflection.steps[index].title,
      style: theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.primary),
    );
  }
}

class _QNAWidget extends StatelessWidget {
  final Map<String, String?> qna;
  const _QNAWidget({super.key, required this.theme, required this.qna});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(qna.keys.first, style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary)),
        SizedBox(height: theme.mediumPaddingDouble),
        Container(
          decoration: BoxDecoration(color: theme.colorScheme.primaryContainer, borderRadius: BorderRadius.circular(8)),

          child: Padding(
            padding: theme.mediumPadding,
            child: Text(
              qna.values.first ?? "Тут пусто",
              style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary),
            ),
          ),
        ),
        SizedBox(height: theme.largePaddingDouble),
      ],
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({super.key, required this.reflection, required this.theme});

  final ReflectionModel reflection;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Text(
        reflection.description,
        style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary),
      ),
    );
  }
}

class _SeparatorWidget extends StatelessWidget {
  const _SeparatorWidget({super.key, required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(height: theme.smallPaddingDouble / 2, width: double.maxFinite, color: theme.colorScheme.primary),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({super.key, required this.reflection, required this.theme});

  final ReflectionModel reflection;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Text(
        "Рефлексия: ${reflection.title}",
        style: theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.primary),
      ),
    );
  }
}
