import 'package:flutter/material.dart';
import 'package:ruminate/core/providers/navigation_providers.dart';

BottomNavigationBar createBottomNavigationBar(
  BuildContext context,
  NavigationNotifier navigationProvider,
  int navigationIndex,
) {
  return BottomNavigationBar(
    selectedItemColor: Theme.of(context).colorScheme.onPrimary,
    unselectedItemColor: Theme.of(context).colorScheme.onPrimary.withAlpha(120),
    onTap: (index) => navigationProvider.goTo(index),
    currentIndex: navigationIndex,
    backgroundColor: Theme.of(context).colorScheme.primary,

    items: [
      BottomNavigationBarItem(icon: Icon(Icons.home_work_outlined), label: "Главная"),
      BottomNavigationBarItem(icon: Icon(Icons.pie_chart_outline), label: "Статистика"),
      BottomNavigationBarItem(icon: Icon(Icons.account_box_outlined), label: "Профиль"),
    ],
  );
}
