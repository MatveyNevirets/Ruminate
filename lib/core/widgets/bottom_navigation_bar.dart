import 'package:flutter/material.dart';
import 'package:ruminate/core/view_models/navigation_view_model.dart';

Widget createBottomNavigationBar(
  BuildContext context,
  NavigationViewModel navigationProvider,
  int navigationIndex,
) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  return SafeArea(
    top: false,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Material(
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.08),
          child: BottomNavigationBar(
            currentIndex: navigationIndex,
            onTap: navigationProvider.goTo,
            type: BottomNavigationBarType.fixed,
            backgroundColor: colorScheme.surface,
            selectedItemColor: colorScheme.primary,
            unselectedItemColor: colorScheme.onSurface.withOpacity(0.52),
            showUnselectedLabels: true,
            selectedLabelStyle: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelStyle: theme.textTheme.labelSmall,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_work_outlined),
                activeIcon: Icon(Icons.home_work_rounded),
                label: "Главная",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart_outline),
                activeIcon: Icon(Icons.pie_chart_rounded),
                label: "Статистика",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_box_outlined),
                activeIcon: Icon(Icons.account_box_rounded),
                label: "Профиль",
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
