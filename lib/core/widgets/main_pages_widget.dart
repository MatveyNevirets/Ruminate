import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/providers/navigation_providers.dart';
import 'package:ruminate/core/widgets/bottom_navigation_bar.dart';
import 'package:ruminate/features/home/presentation/home_screen.dart';

class MainPagesWidget extends ConsumerWidget {
  const MainPagesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(pageControllerProvider);

    final navigationProvider = ref.watch(navigationViewModel.notifier);
    final navigationIndex = ref.watch(navigationViewModel);

    return PageView(
      controller: controller,

      children: [
        HomeScreen(),
        Scaffold(
          body: Center(
            child: Text(
              "Здесь будет статистика",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          bottomNavigationBar: createBottomNavigationBar(context, navigationProvider, navigationIndex),
        ),
        Scaffold(
          body: Center(
            child: Text(
              "Здесь будет профиль",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          bottomNavigationBar: createBottomNavigationBar(context, navigationProvider, navigationIndex),
        ),
      ],
    );
  }
}
