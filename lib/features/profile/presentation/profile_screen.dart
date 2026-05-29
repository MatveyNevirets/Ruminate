import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/providers/navigation_providers.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/themes/app_themes.dart';
import 'package:ruminate/core/view_models/settings_view_model.dart';
import 'package:ruminate/core/view_models/you_thought_view_model.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/core/widgets/app_dual_state_button.dart';
import 'package:ruminate/core/widgets/bottom_navigation_bar.dart';
import 'package:ruminate/core/widgets/snack_bar.dart';
import 'package:ruminate/features/start/enum/start_state.dart';
import 'package:ruminate/features/start/presentation/view_model/start_view_model.dart';
import 'package:ruminate/features/sync/presentation/widgets/obsidian_sync_button.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late final Future<bool> _passwordExistsFuture;

  @override
  void initState() {
    super.initState();
    final settingsViewModel = ref.read(settingsViewModelProvider.notifier);
    _passwordExistsFuture = settingsViewModel.isPasswordExistsCheck();
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = ref.watch(navigationViewModel.notifier);
    final navigationIndex = ref.watch(navigationViewModel);
    final settingsViewModel = ref.watch(settingsViewModelProvider.notifier);
    final startStateViewModel = ref.watch(startViewModelProvider.notifier);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      bottomNavigationBar: createBottomNavigationBar(
        context,
        navigationProvider,
        navigationIndex,
      ),
      body: Stack(
        children: [
          Positioned(
            top: -120,
            right: -100,
            child: Container(
              width: 320,
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(56),
                color: colorScheme.primary.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            top: 260,
            left: -120,
            child: Container(
              width: 260,
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(42),
                color: colorScheme.primary.withOpacity(0.04),
              ),
            ),
          ),
          Positioned(
            bottom: -170,
            right: -100,
            child: Container(
              width: 360,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(64),
                color: colorScheme.primary.withOpacity(0.05),
              ),
            ),
          ),
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: theme.largePadding.copyWith(top: 8),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ProfileHeroCard(
                          title: "Профиль",
                          subtitle:
                              "Экспорт, конфиденциальность и оформление приложения в одном месте.",
                          icon: Icons.account_circle_rounded,
                        ),

                        SizedBox(height: theme.largePaddingDouble),

                        _SectionTitle(
                          title: "Экспорт",
                          subtitle:
                              "Сохрани данные и перенеси их через файловый менеджер.",
                        ),
                        SizedBox(height: theme.mediumPaddingDouble),
                        _SurfaceCard(
                          accent: colorScheme.primary,
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 52,
                                      width: 52,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(18),
                                        color: colorScheme.primary.withOpacity(
                                          0.11,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.archive_rounded,
                                        color: colorScheme.primary,
                                        size: 26,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Экспорт в Obsidian",
                                            style: theme.textTheme.titleLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w800,
                                                  height: 1.15,
                                                ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            "Для экспорта понадобятся проводник и архиватор.",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                                  color: colorScheme.onSurface
                                                      .withOpacity(0.62),
                                                  height: 1.5,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 22),
                                ObsidianSyncButton(),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: theme.largePaddingDouble * 1.15),

                        _SectionTitle(
                          title: "Конфиденциальность",
                          subtitle: "Действия с паролем и защитой данных.",
                        ),
                        SizedBox(height: theme.mediumPaddingDouble),
                        _SurfaceCard(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: FutureBuilder<bool>(
                              future: _passwordExistsFuture,
                              builder: (context, asyncSnapshot) {
                                if (asyncSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const SizedBox(
                                    height: 120,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }

                                if (asyncSnapshot.hasError) {
                                  return _StatusCard(
                                    icon: Icons.error_outline_rounded,
                                    title: "Не удалось загрузить состояние",
                                    subtitle: "Попробуй открыть экран ещё раз.",
                                    accent: colorScheme.error,
                                  );
                                }

                                final hasPassword = asyncSnapshot.data == true;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        _MiniStatusChip(
                                          text: hasPassword
                                              ? "Пароль включён"
                                              : "Пароль не задан",
                                          color: hasPassword
                                              ? colorScheme.primary
                                              : colorScheme.tertiary,
                                        ),
                                        const Spacer(),
                                        Icon(
                                          hasPassword
                                              ? Icons.lock_rounded
                                              : Icons.lock_open_rounded,
                                          color: colorScheme.onSurface
                                              .withOpacity(0.38),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 18),
                                    Text(
                                      hasPassword
                                          ? "Сейчас пароль уже установлен. Можешь изменить его или удалить."
                                          : "Пароль пока не установлен. Добавь его, чтобы защитить доступ.",
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: colorScheme.onSurface
                                                .withOpacity(0.66),
                                            height: 1.55,
                                          ),
                                    ),
                                    const SizedBox(height: 22),
                                    if (hasPassword) ...[
                                      AppButton(
                                        onClick: () {
                                          startStateViewModel.changeState(
                                            StartState.onBoarding,
                                          );
                                          context.go(
                                            "/onBoarding/before_start/password_set",
                                          );
                                        },
                                        text: "Изменить пароль",
                                      ),
                                      const SizedBox(height: 14),
                                      AppButton(
                                        onClick: () async {
                                          final result = await settingsViewModel
                                              .deletePassword();

                                          if (!mounted) return;

                                          if (result) {
                                            showSnackBar(
                                              context,
                                              "Пароль успешно удален!",
                                            );
                                            setState(() {
                                              _passwordExistsFuture; // no-op, keeps structure stable
                                            });
                                          }
                                        },
                                        text: "Удалить пароль",
                                      ),
                                    ] else ...[
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
                                  ],
                                );
                              },
                            ),
                          ),
                        ),

                        SizedBox(height: theme.largePaddingDouble * 1.15),

                        _SectionTitle(
                          title: "Цвет темы",
                          subtitle:
                              "Выбери палитру, которая лучше совпадает с настроением приложения.",
                        ),
                        SizedBox(height: theme.mediumPaddingDouble),
                        _SurfaceCard(
                          accent: colorScheme.primary,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: ColorRadioButtonGroup(),
                          ),
                        ),

                        SizedBox(height: theme.largePaddingDouble * 2),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ColorRadioButtonGroup extends ConsumerStatefulWidget {
  const ColorRadioButtonGroup({super.key});

  @override
  ConsumerState<ColorRadioButtonGroup> createState() =>
      _ColorRadioButtonGroupState();
}

class _ColorRadioButtonGroupState extends ConsumerState<ColorRadioButtonGroup> {
  late final PageController _pageController;
  late final Future<bool> _initFuture;
  late final List<Color> _colors;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.86);

    // В AppThemes.getThemes сейчас 4 готовые темы, поэтому берём ровно их.
    _colors = AppThemes.seedColors.take(AppThemes.getThemes.length).toList();

    final settingsViewModel = ref.read(settingsViewModelProvider.notifier);
    _initFuture = settingsViewModel.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settingsViewModel = ref.watch(settingsViewModelProvider.notifier);
    final settingsViewModelState = ref.watch(settingsViewModelProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return FutureBuilder<bool>(
      future: _initFuture,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 320,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (asyncSnapshot.hasError || asyncSnapshot.data != true) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: _StatusCard(
              icon: Icons.error_outline_rounded,
              title: "Не удалось загрузить темы",
              subtitle: "Попробуй открыть экран ещё раз.",
              accent: colorScheme.error,
            ),
          );
        }

        return SizedBox(
          height: 330,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _colors.length,
            itemBuilder: (context, index) {
              final isSelected = index < settingsViewModelState.length
                  ? settingsViewModelState[index]
                  : false;

              return ColorRadioButton(
                color: _colors[index],
                isSelected: isSelected,
                onClick: () {
                  settingsViewModel.changeTheme(index);
                },
                title: "Тема ${index + 1}",
                subtitle: "Мягкая палитра без резких контрастов",
              );
            },
          ),
        );
      },
    );
  }
}

class ColorRadioButton extends StatelessWidget {
  const ColorRadioButton({
    super.key,
    required this.color,
    required this.isSelected,
    required this.onClick,
    required this.title,
    required this.subtitle,
  });

  final Color color;
  final bool isSelected;
  final VoidCallback onClick;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: _SurfaceCard(
        accent: color,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        color.withOpacity(0.28),
                        colorScheme.surfaceContainerHighest.withOpacity(0.18),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                  child: const SizedBox(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: color.withOpacity(0.14),
                            border: Border.all(color: color.withOpacity(0.12)),
                          ),
                          child: Icon(
                            Icons.palette_rounded,
                            color: color,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  height: 1.15,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                subtitle,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurface.withOpacity(
                                    0.62,
                                  ),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: colorScheme.surface.withOpacity(0.46),
                        border: Border.all(
                          color: colorScheme.onSurface.withOpacity(0.06),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isSelected
                                      ? "Тема уже выбрана"
                                      : "Сделать активной",
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  isSelected
                                      ? "Эта палитра сейчас используется в приложении."
                                      : "Нажми, чтобы применить эту тему.",
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurface.withOpacity(
                                      0.60,
                                    ),
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            height: 58,
                            width: 132,
                            child: AppDualStateButton(
                              isSelected: isSelected,
                              radius: theme.largePaddingDouble,
                              onClick: onClick,
                              text: "Выбрать",
                              selectedText: "Выбрано",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeroCard extends StatelessWidget {
  const _ProfileHeroCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _SurfaceCard(
      accent: colorScheme.primary,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary.withOpacity(0.10),
              colorScheme.surfaceContainerHighest.withOpacity(0.14),
            ],
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: colorScheme.primary.withOpacity(0.14),
                border: Border.all(
                  color: colorScheme.primary.withOpacity(0.10),
                ),
              ),
              child: Icon(icon, size: 36, color: colorScheme.primary),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.0,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.64),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withOpacity(0.60),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _MiniStatusChip extends StatelessWidget {
  const _MiniStatusChip({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.10)),
      ),
      child: Text(
        text,
        style: theme.textTheme.labelMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: accent.withOpacity(0.08),
        border: Border.all(color: accent.withOpacity(0.10)),
      ),
      child: Row(
        children: [
          Icon(icon, color: accent, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.65),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SurfaceCard extends StatelessWidget {
  const _SurfaceCard({required this.child, this.accent});

  final Widget child;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final borderColor = (accent ?? colorScheme.onSurface).withOpacity(0.08);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: colorScheme.surface,
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            blurRadius: 26,
            offset: const Offset(0, 12),
            color: Colors.black.withOpacity(0.045),
          ),
        ],
      ),
      child: child,
    );
  }
}
