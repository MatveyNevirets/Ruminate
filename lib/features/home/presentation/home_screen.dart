// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/providers/navigation_providers.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/utils/utils.dart';
import 'package:ruminate/core/view_models/you_thought_view_model.dart';
import 'package:ruminate/core/widgets/bottom_navigation_bar.dart';

class YouThoughtSliverWidget extends StatelessWidget {
  const YouThoughtSliverWidget({
    super.key,
    required this.youThoughtList,
    required this.youThoughtVM,
  });

  final List<dynamic> youThoughtList;
  final YouThoughtViewModel youThoughtVM;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverPadding(
      padding: theme.largePadding.copyWith(top: 10),
      sliver: SliverToBoxAdapter(
        child: _ThoughtHeroCard(
          youThoughtList: youThoughtList,
          youThoughtVM: youThoughtVM,
        ),
      ),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationProvider = ref.watch(navigationViewModel.notifier);
    final navigationIndex = ref.watch(navigationViewModel);
    final youThoughtVM = ref.watch(youThoughtVMProvider.notifier);
    final youThought = ref.watch(youThoughtVMProvider);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      bottomNavigationBar: createBottomNavigationBar(
        context,
        navigationProvider,
        navigationIndex,
      ),
      body: Stack(
        children: [
          Positioned(
            top: -150,
            right: -110,
            child: Container(
              width: 350,
              height: 270,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(56),
                color: colorScheme.primary.withOpacity(0.06),
              ),
            ),
          ),
          Positioned(
            top: 230,
            left: -140,
            child: Container(
              width: 290,
              height: 210,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(44),
                color: colorScheme.primary.withOpacity(0.035),
              ),
            ),
          ),
          Positioned(
            bottom: -180,
            right: -100,
            child: Container(
              width: 380,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(66),
                color: colorScheme.primary.withOpacity(0.045),
              ),
            ),
          ),
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
                youThought.when(
                  loading: () =>
                      const SliverToBoxAdapter(child: SizedBox(height: 26)),
                  error: (e, stack) {
                    return SliverPadding(
                      padding: theme.largePadding,
                      sliver: SliverToBoxAdapter(
                        child: _SurfaceCard(
                          child: _StatusCard(
                            icon: Icons.error_outline_rounded,
                            title: "Не удалось загрузить мысль",
                            subtitle:
                                "Попробуй обновить экран или зайти чуть позже.",
                            accent: colorScheme.error,
                          ),
                        ),
                      ),
                    );
                  },
                  data: (youThoughtList) {
                    if (youThoughtList == null) {
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
                    }

                    return YouThoughtSliverWidget(
                      youThoughtList: youThoughtList,
                      youThoughtVM: youThoughtVM,
                    );
                  },
                ),
                SliverPadding(
                  padding: theme.largePadding.copyWith(top: 14),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionTitle(
                          title: "Рефлексируй",
                          subtitle:
                              "Записывай состояние, мысли и наблюдения дня.",
                        ),
                        SizedBox(height: theme.mediumPaddingDouble * 1.2),
                        _PrimaryActionCard(
                          title: "Ежедневная\nрефлексия",
                          subtitle: "Спокойно разложи день по полочкам.",
                          icon: Icons.auto_awesome_rounded,
                          onTap: () => context.go("/home/daily_reflection"),
                        ),
                        SizedBox(height: theme.mediumPaddingDouble * 1.15),
                        Row(
                          children: [
                            Expanded(
                              child: _CompactActionCard(
                                title: "Создать\nрефлексию",
                                subtitle: "Быстрый старт",
                                icon: Icons.edit_note_rounded,
                                onTap: () {},
                                isComingSoon: true,
                              ),
                            ),
                            SizedBox(width: theme.mediumPaddingDouble),
                            Expanded(
                              child: _CompactActionCard(
                                title: "Ежемесячная\nрефлексия",
                                subtitle: "Сводка месяца",
                                icon: Icons.calendar_month_rounded,
                                onTap: () =>
                                    context.go("/home/month_reflection/"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: theme.largePaddingDouble * 1.45),
                        _SectionTitle(
                          title: "Вспомни",
                          subtitle:
                              "Посмотри на собственные паттерны и повторения.",
                        ),
                        SizedBox(height: theme.mediumPaddingDouble * 1.15),
                        _WideActionCard(
                          title: "Все рефлексии",
                          subtitle: "Архив мыслей. Все то, что ты уже прошёл.",
                          icon: Icons.library_books_rounded,
                          onTap: () =>
                              context.go("/home/completed_reflections"),
                        ),
                        SizedBox(height: theme.mediumPaddingDouble),
                        _WideActionCard(
                          title: "Личные победы",
                          subtitle:
                              "Накопление маленьких, но важных подтверждений роста.",
                          icon: Icons.workspace_premium_rounded,
                          onTap: () => context.go("/home/personal_victories"),
                        ),
                        SizedBox(height: theme.largePaddingDouble * 2.2),
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
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ThoughtHeroCard extends StatelessWidget {
  const _ThoughtHeroCard({
    required this.youThoughtList,
    required this.youThoughtVM,
  });

  final List<dynamic> youThoughtList;
  final YouThoughtViewModel youThoughtVM;

  String _safeQuestion() {
    try {
      final raw = youThoughtList[1]?.keys.first?.toString() ?? "";
      return raw.isEmpty ? "Без вопроса" : raw;
    } catch (_) {
      return "Без вопроса";
    }
  }

  String _safeAnswer() {
    try {
      final raw = youThoughtList[1]?.values.first?.toString() ?? "";
      return raw.isEmpty ? "Без ответа" : raw;
    } catch (_) {
      return "Без ответа";
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final question = Utils.cutStringByChars(_safeQuestion(), 90);
    final answer = Utils.cutStringByChars(_safeAnswer(), 180);
    final dateText = Utils.fetchDateFromReflection(youThoughtVM.reflection!);
    final dateLabel = Utils.fetchTextDateFromReflection(
      youThoughtVM.reflection!,
    );

    return _SurfaceCard(
      accent: colorScheme.primary,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            context.go("/home/details/", extra: youThoughtList[0]);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primary.withOpacity(0.12),
                  colorScheme.surfaceContainerHighest.withOpacity(0.08),
                ],
              ),
            ),
            padding: const EdgeInsets.all(26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _PillLabel(
                      text: "Ты думал об этом раньше",
                      color: colorScheme.primary,
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_outward_rounded,
                      size: 20,
                      color: colorScheme.onSurface.withOpacity(0.42),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  question,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                    letterSpacing: -0.6,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  answer,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.72),
                    height: 1.72,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Icon(
                      Icons.schedule_rounded,
                      size: 18,
                      color: colorScheme.onSurface.withOpacity(0.42),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "$dateLabel • $dateText",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.52),
                        ),
                      ),
                    ),
                    Text(
                      "Открыть",
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
            color: colorScheme.onSurface.withOpacity(0.6),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _PrimaryActionCard extends StatelessWidget {
  const _PrimaryActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _SurfaceCard(
      accent: colorScheme.primary,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(26),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: colorScheme.surfaceContainerLow.withOpacity(0.72),
            ),
            child: Row(
              children: [
                Container(
                  height: 68,
                  width: 68,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: colorScheme.primary.withOpacity(0.11),
                  ),
                  child: Icon(icon, color: colorScheme.primary, size: 30),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          height: 1.18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.66),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CompactActionCard extends StatelessWidget {
  const _CompactActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.isComingSoon = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool isComingSoon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _SurfaceCard(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: isComingSoon ? null : onTap,
          child: Container(
            height: 170,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: colorScheme.surfaceContainerHighest.withOpacity(
                isComingSoon ? 0.11 : 0.18,
              ),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withOpacity(
                              isComingSoon ? 0.06 : 0.10,
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            icon,
                            size: 24,
                            color: isComingSoon
                                ? colorScheme.onSurface.withOpacity(0.22)
                                : colorScheme.primary,
                          ),
                        ),
                        const Spacer(),
                        if (isComingSoon)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.onSurface.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(
                                color: colorScheme.onSurface.withOpacity(0.08),
                              ),
                            ),
                            child: Text(
                              "СКОРО",
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: colorScheme.onSurface.withOpacity(0.52),
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        height: 1.22,
                        color: isComingSoon
                            ? colorScheme.onSurface.withOpacity(0.40)
                            : colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isComingSoon
                            ? colorScheme.onSurface.withOpacity(0.30)
                            : colorScheme.onSurface.withOpacity(0.55),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WideActionCard extends StatelessWidget {
  const _WideActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _SurfaceCard(
      accent: colorScheme.primary,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: colorScheme.surfaceContainerHighest.withOpacity(0.14),
            ),
            child: Row(
              children: [
                Container(
                  height: 58,
                  width: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: colorScheme.primary.withOpacity(0.11),
                  ),
                  child: Icon(icon, color: colorScheme.primary),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.66),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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

class _PillLabel extends StatelessWidget {
  const _PillLabel({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.08)),
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
      padding: const EdgeInsets.all(24),
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
