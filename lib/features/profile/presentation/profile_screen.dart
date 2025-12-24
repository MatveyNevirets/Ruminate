import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/auth/data/auth_params/login_params.dart';
import 'package:ruminate/core/auth/presentation/view_model/auth_view_model.dart';
import 'package:ruminate/core/auth/usecases/google_login_usecase.dart';
import 'package:ruminate/core/providers/navigation_providers.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/themes/app_themes.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/core/widgets/app_dual_state_button.dart';
import 'package:ruminate/core/widgets/bottom_navigation_bar.dart';
import 'package:ruminate/core/widgets/separator_widget.dart';
import 'package:ruminate/core/view_models/settings_view_model.dart';
import 'package:ruminate/core/widgets/snack_bar.dart';
import 'package:ruminate/features/intro/presentation/view_model/password_view_model.dart';
import 'package:ruminate/features/start/enum/start_state.dart';
import 'package:ruminate/features/start/presentation/view_model/start_view_model.dart';
import 'package:ruminate/features/sync/presentation/widgets/obsidian_sync_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationProvider = ref.watch(navigationViewModel.notifier);
    final navigationIndex = ref.watch(navigationViewModel);
    final settingsViewModel = ref.watch(settingsViewModelProvider.notifier);
    final startStateViewModel = ref.watch(startViewModelProvider.notifier);
    final firebaseAuthVM = ref.watch(firebaseAuthViewModel.notifier);
    final firebaseAuthState = ref.watch(firebaseAuthViewModel);

    final theme = Theme.of(context);

    return Scaffold(
      appBar: createAppBar(context, title: "Профиль"),
      body: SingleChildScrollView(
        child: Padding(
          padding: theme.largePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Экспорт",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: theme.mediumPaddingDouble),
                  Text(
                    "Для экспорта вам понадобиться приложение проводника, чтобы сохранить файл в папку, а затем разархивировать его",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),

              SizedBox(height: theme.extraLargePaddingDouble),
              ObsidianSyncButton(),

              SizedBox(height: theme.extraLargePaddingDouble),
              SeparatorWidget(),

              SizedBox(height: theme.extraLargePaddingDouble),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Конфиденциальность",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: theme.mediumPaddingDouble),
                  Text(
                    "Доступные действия с паролем",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: theme.extraLargePaddingDouble),

              FutureBuilder(
                future: settingsViewModel.isPasswordExistsCheck(),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.hasData) {
                    if (asyncSnapshot.data == true) {
                      return Column(
                        children: [
                          AppButton(
                            onClick: () {
                              startStateViewModel.changeState(
                                StartState.onBoarding,
                              );
                              context.go(
                                "/onBoarding/before_start/password_set",
                              );
                            },
                            text: "Изменить",
                          ),
                          SizedBox(height: theme.largePaddingDouble),
                          AppButton(
                            onClick: () async {
                              final result = await settingsViewModel
                                  .deletePassword();
                              if (result) {
                                // ignore: use_build_context_synchronously
                                showSnackBar(context, "Пароль успешно удален!");
                              }
                            },
                            text: "Удалить",
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          AppButton(
                            onClick: () {
                              startStateViewModel.changeState(
                                StartState.onBoarding,
                              );
                              context.go(
                                "/onBoarding/before_start/password_set",
                              );
                            },
                            text: "Установить пароль",
                          ),
                        ],
                      );
                    }
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),

              SizedBox(height: theme.extraLargePaddingDouble),
              SeparatorWidget(),
              SizedBox(height: theme.extraLargePaddingDouble),
              Column(
                children: [
                  firebaseAuthState.when(
                    data: (data) {
                      return Text(data != null ? "Вы вошли" : "Не вошли");
                    },
                    error: (Object error, StackTrace stackTrace) {
                      return Text("Ошибка!");
                    },
                    loading: () {
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                  AppButton(
                    onClick: () =>
                        firebaseAuthVM.loginWithGoogle(GoogleLoginUsecase()),
                    text: "Войти в аккаунт",
                  ),
                ],
              ),
              SizedBox(height: theme.extraLargePaddingDouble),
              SeparatorWidget(),
              SizedBox(height: theme.extraLargePaddingDouble),
              Text(
                "Цвет темы",
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              SizedBox(height: theme.extraLargePaddingDouble),
              ColorRadioButtonGroup(),
              SizedBox(height: theme.extraLargePaddingDouble),
            ],
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
    final settingsViewModel = ref.watch(settingsViewModelProvider.notifier);
    final settingsViewModelState = ref.watch(settingsViewModelProvider);

    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 5,
      child: FutureBuilder(
        future: settingsViewModel.initState(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            if (asyncSnapshot.data == true) {
              return PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  return ColorRadioButton(
                    isSelected: settingsViewModelState[index],
                    color: colors[index],
                    onClick: () {
                      settingsViewModel.changeTheme(index);
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
              height: MediaQuery.sizeOf(context).height,

              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),

                color: color,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height / 12,
            left: MediaQuery.sizeOf(context).width / 8,
            right: MediaQuery.sizeOf(context).width / 8,
            child: SizedBox(
              height: 60,
              width: 200,
              child: AppDualStateButton(
                isSelected: isSelected,
                radius: theme.largePaddingDouble,
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
