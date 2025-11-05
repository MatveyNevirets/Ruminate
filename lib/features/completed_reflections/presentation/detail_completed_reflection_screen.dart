import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ruminate/core/data/model/reflection_model.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';

class DetailCompletedReflectionScreen extends StatelessWidget {
  final ReflectionModel reflection;
  const DetailCompletedReflectionScreen({super.key, required this.reflection});

  //   String title;
  //   String description;
  //   ReflectType type;
  //   List<ReflectionStepModel> steps;

  //   |
  //  |
  // V

  //  final String title;
  //   final String description;
  //   final List<Map<String, String?>> questionsAndAnswers;

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
            SliverToBoxAdapter(
              child: Text(
                "Рефлексия: ${reflection.title}",
                style: theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.primary),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: theme.mediumPaddingDouble)),
            SliverToBoxAdapter(
              child: Container(
                height: theme.smallPaddingDouble / 2,
                width: double.maxFinite,
                color: theme.colorScheme.primary,
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: theme.mediumPaddingDouble)),
            SliverToBoxAdapter(
              child: Text(
                reflection.description,
                style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: theme.largePaddingDouble)),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reflection.steps[index].title,
                      style: theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.primary),
                    ),
                    SizedBox(height: theme.mediumPaddingDouble),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: reflection.steps[index].questionsAndAnswers
                          .map(
                            (qna) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  qna.keys.first,
                                  style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary),
                                ),
                                SizedBox(height: theme.mediumPaddingDouble),
                                Container(
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primaryContainer,
                                    borderRadius: BorderRadius.circular(8),
                                  ),

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
                            ),
                          )
                          .toList(),
                    ),
                  ],
                );
              }, childCount: reflection.steps.length),
            ),
          ],
        ),
      ),
    );
  }
}
