import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/providers/navigation_providers.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/themes/app_themes.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/core/widgets/app_dual_state_button.dart';
import 'package:ruminate/core/widgets/bottom_navigation_bar.dart';
import 'package:ruminate/core/widgets/separator_widget.dart';
import 'package:ruminate/features/profile/presentation/view_model/theme_change_view_model.dart';
import 'package:ruminate/features/sync/presentation/widgets/obsidian_sync_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationProvider = ref.watch(navigationViewModel.notifier);
    final navigationIndex = ref.watch(navigationViewModel);

    final theme = Theme.of(context);

    return Scaffold(
      appBar: createAppBar(context, title: "Профиль"),
      body: SingleChildScrollView(
        child: Padding(
          padding: theme.largePadding,
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "Экспорт",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                ObsidianSyncButton(),
                Expanded(child: SizedBox()),
                SeparatorWidget(),
                Expanded(child: SizedBox()),
                Expanded(
                  child: Text(
                    "Конфиденциальность",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                AppButton(onClick: () {}, text: "Установить"),
                AppButton(onClick: () {}, text: "Изменить"),
                AppButton(onClick: () {}, text: "Удалить"),
                Expanded(child: SizedBox()),
                SeparatorWidget(),
                Expanded(child: SizedBox()),
                Expanded(
                  child: Text(
                    "Цвет темы",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                ColorRadioButtonGroup(),
                Expanded(child: SizedBox()),
                Row(
                  children: [
                    AppButton(
                      onClick: () {},
                      text: "Отменить",
                      buttonSize: Size(
                        MediaQuery.sizeOf(context).width / 2.2,
                        MediaQuery.sizeOf(context).width / 8,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    AppButton(
                      onClick: () {},
                      text: "Сохранить",
                      buttonSize: Size(
                        MediaQuery.sizeOf(context).width / 2.2,
                        MediaQuery.sizeOf(context).width / 8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: createBottomNavigationBar(
        context,
        navigationProvider,
        navigationIndex,
      ),
    );
  }
}

class ColorRadioButtonGroup extends ConsumerWidget {
  ColorRadioButtonGroup({super.key});

  final colors = AppThemes.seedColors;
  final _pageController = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeChangeViewModel = ref.watch(
      themeChangeViewModelProvider.notifier,
    );
    final themeChangeViewModelState = ref.watch(themeChangeViewModelProvider);

    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 5,
      child: FutureBuilder(
        future: themeChangeViewModel.initState(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            if (asyncSnapshot.data == true) {
              return PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  return ColorRadioButton(
                    isSelected: themeChangeViewModelState[index],
                    color: colors[index],
                    onClick: () {
                      log("click");
                      themeChangeViewModel.changeTheme(index);
                    },
                  );
                },
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ColorRadioButton extends StatelessWidget {
  const ColorRadioButton({
    super.key,
    required this.color,

    required this.isSelected,
    required this.onClick,
  });

  final Color color;
  final bool isSelected;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: theme.mediumPadding,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              height: MediaQuery.sizeOf(context).height / 2,

              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),

                color: color,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height / 10,
            left: MediaQuery.sizeOf(context).width / 8,
            right: MediaQuery.sizeOf(context).width / 8,
            child: SizedBox(
              height: 60,
              width: 200,
              child: AppDualStateButton(
                isSelected: isSelected,
                onClick: () => onClick.call(),
                text: "Выбрать",
                selectedText: "Выбрано",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
