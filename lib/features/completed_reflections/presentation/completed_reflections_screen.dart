import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_container.dart';
import 'package:ruminate/features/completed_reflections/presentation/providers/completed_reflections_view_model.dart';

class CompletedReflectionsScreen extends ConsumerWidget {
  const CompletedReflectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reflectionVMProvider = ref.watch(completedReflectionsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: createAppBar(context),
      body: CustomScrollView(
        slivers: [
          SliverPadding(padding: EdgeInsets.symmetric(vertical: theme.largePaddingDouble)),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: theme.largePaddingDouble),
            sliver: reflectionVMProvider.when(
              loading: () => SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
              error: (e, stack) {
                log("Exception at completed reflection screen. Exception: $e StackTrace: $stack");
                return SliverToBoxAdapter(child: Center(child: Text("Что-то пошло не так :(")));
              },
              data: (reflections) => reflections == null
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          "Тут пока ничего нет",
                          style: theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.primary),
                        ),
                      ),
                    )
                  : SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: theme.mediumPaddingDouble,
                        crossAxisSpacing: theme.mediumPaddingDouble,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return AppContainer(
                          title: reflections[index].title,
                          onClick: () => context.go("/home/details", extra: reflections[index]),
                        );
                      }, childCount: reflections.length),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
