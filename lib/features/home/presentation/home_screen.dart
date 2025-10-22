import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/providers/navigation_providers.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_container.dart';
import 'package:ruminate/core/widgets/bottom_navigation_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationProvider = ref.watch(navigationNotifierProvider.notifier);
    final navigationIndex = ref.watch(navigationNotifierProvider);

    return Scaffold(
      appBar: createAppBar(context),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: Theme.of(context).largePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Рефлексируй!",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  SizedBox(height: Theme.of(context).mediumPaddingDouble),
                  Row(
                    children: [
                      Expanded(
                        child: AppContainer(
                          title: "Ежедневная рефлексия",
                          onClick: () => context.go("/home/daily_reflection"),
                        ),
                      ),
                      SizedBox(width: Theme.of(context).mediumPaddingDouble),
                      Expanded(child: AppContainer(title: "Создать рефлексию")),
                    ],
                  ),
                  SizedBox(height: Theme.of(context).mediumPaddingDouble),
                  SizedBox(
                    width: double.maxFinite,
                    child: AppContainer(
                      title: "Ежемесячная рефлексия",
                      onClick: () => context.go("/home/month_reflection/"),
                    ),
                  ),
                  SizedBox(height: Theme.of(context).largePaddingDouble),
                  Text(
                    "Вспомни!",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  SizedBox(height: Theme.of(context).mediumPaddingDouble),
                  Row(
                    children: [
                      Expanded(child: AppContainer(title: "Все рефлексии")),
                      SizedBox(width: Theme.of(context).mediumPaddingDouble),
                      Expanded(child: AppContainer(title: "Неделю назад ты думал о..")),
                    ],
                  ),
                  SizedBox(height: Theme.of(context).mediumPaddingDouble),
                  SizedBox(
                    width: double.maxFinite,
                    child: AppContainer(title: "Личные победы"),
                  ),
                  SizedBox(height: Theme.of(context).largePaddingDouble),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: createBottomNavigationBar(context, navigationProvider, navigationIndex),
    );
  }
}
