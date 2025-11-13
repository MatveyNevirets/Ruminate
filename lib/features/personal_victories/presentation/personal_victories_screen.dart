import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_container.dart';
import 'package:ruminate/features/personal_victories/presentation/viewmodel/personal_victories_view_model.dart';

class PersonalVictoriesScreen extends ConsumerWidget {
  const PersonalVictoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final victoriesVM = ref.watch(personalVictoriesVMProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: createAppBar(context),
      body: victoriesVM.when(
        data: (victories) {
          if (victories != null) {
            return CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: theme.largePadding.copyWith(top: theme.largePadding.top * 2),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      "Твои победы за все время:",
                      style: theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.primary),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: theme.largePadding,
                  sliver: SliverList.builder(
                    itemCount: victories.length,
                    itemBuilder: (context, index) {
                      return AppContainer(title: victories[index], onClick: () => ());
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text(
                "Тут пока пусто",
                style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary),
              ),
            );
          }
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, stack) {
          log("Exception at the PersonalVictoriesViewModel in method fetchVictories(): $e StackTrace: $stack");
          return Center(
            child: Text(
              "Что-то пошло не так :(",
              style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary),
            ),
          );
        },
      ),
    );
  }
}
