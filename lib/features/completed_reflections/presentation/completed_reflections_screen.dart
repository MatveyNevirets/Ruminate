import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_container.dart';
import 'package:ruminate/features/home/providers/completed_reflections_view_model.dart';

class CompletedReflectionsScreen extends ConsumerWidget {
  const CompletedReflectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reflectionVMProvider = ref.watch(completedReflectionsProvider);

    return Scaffold(
      appBar: createAppBar(context),
      body: CustomScrollView(
        slivers: [
          SliverPadding(padding: EdgeInsets.symmetric(vertical: Theme.of(context).largePaddingDouble)),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: Theme.of(context).largePaddingDouble),
            sliver: reflectionVMProvider.when(
              loading: () => SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
              error: (e, stack) {
                log("Exception at completed reflection screen. Exception: $e StackTrace: $stack");
                return SliverToBoxAdapter(child: Center(child: Text("Что-то пошло не так :(")));
              },
              data: (reflections) => SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: Theme.of(context).mediumPaddingDouble,
                  crossAxisSpacing: Theme.of(context).mediumPaddingDouble,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  return AppContainer(title: reflections[index].title);
                }, childCount: reflections.length),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
