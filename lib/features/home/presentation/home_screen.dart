import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/providers/page_controller_provider.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_container.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifierProvider = ref.watch(pageProvider.notifier);
    final pageIndexProvider = ref.watch(pageProvider);

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
                    ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
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
                    child: AppContainer(title: "Ежемесячная рефлексия"),
                  ),
                  SizedBox(height: Theme.of(context).largePaddingDouble),
                  Text(
                    "Вспомни!",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
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
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,

        onTap: (index) => pageNotifierProvider.changePage(index),
        currentIndex: pageIndexProvider,
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_work_outlined, color: Theme.of(context).colorScheme.onPrimary),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outline, color: Theme.of(context).colorScheme.onPrimary),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined, color: Theme.of(context).colorScheme.onPrimary),
            label: "",
          ),
        ],
      ),
    );
  }
}
