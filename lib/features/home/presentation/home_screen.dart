import 'dart:ui';

import 'package:flutter/material.dart';
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
      padding: theme.largePadding.copyWith(top: 8),
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
            top: -140,
            right: -100,
            child: Container(
              width: 340,
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(52),
                color: colorScheme.primary.withOpacity(0.07),
              ),
            ),
          ),
          Positioned(
            top: 220,
            left: -130,
            child: Container(
              width: 280,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: colorScheme.primary.withOpacity(0.04),
              ),
            ),
          ),
          Positioned(
            bottom: -160,
            right: -90,
            child: Container(
              width: 360,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: colorScheme.primary.withOpacity(0.05),
              ),
            ),
          ),
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                youThought.when(
                  loading: () =>
                      const SliverToBoxAdapter(child: SizedBox(height: 24)),
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
                  padding: theme.largePadding.copyWith(top: 10),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SectionTitle(
                          title: "Рефлексируй",
                          subtitle:
                              "Записывай состояние, мысли и наблюдения дня.",
                        ),
                        SizedBox(height: theme.mediumPaddingDouble),

                        _PrimaryActionCard(
                          title: "Ежедневная\nрефлексия",
                          subtitle: "Спокойно разложи день по полочкам.",
                          icon: Icons.auto_awesome_rounded,
                          onTap: () => context.go("/home/daily_reflection"),
                        ),

                        SizedBox(height: theme.mediumPaddingDouble),

                        Row(
                          children: [
                            Expanded(
                              child: _CompactActionCard(
                                title: "Создать\nрефлексию",
                                subtitle: "Быстрый старт",
                                icon: Icons.edit_note_rounded,
                                onTap: () {
                                  // TODO: подставь маршрут, когда он появится
                                },
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

                        SizedBox(height: theme.largePaddingDouble * 1.25),

                        _SectionTitle(
                          title: "Вспомни",
                          subtitle:
                              "Посмотри на собственные паттерны и повторения.",
                        ),

                        SizedBox(height: theme.mediumPaddingDouble),

                        Row(
                          children: [
                            Expanded(
                              child: _CompactActionCard(
                                title: "Все\nрефлексии",
                                subtitle: "Архив мыслей",
                                icon: Icons.library_books_rounded,
                                onTap: () =>
                                    context.go("/home/completed_reflections"),
                              ),
                            ),
                            SizedBox(width: theme.mediumPaddingDouble),
                            Expanded(
                              child: _CompactActionCard(
                                title: "Неделю назад\nты думал...",
                                subtitle: "Сравнение с прошлым",
                                icon: Icons.history_rounded,
                                onTap: () {
                                  // TODO: подставь маршрут, когда он появится
                                },
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: theme.mediumPaddingDouble),

                        _WideActionCard(
                          title: "Личные победы",
                          subtitle:
                              "Накопление маленьких, но важных подтверждений роста.",
                          icon: Icons.workspace_premium_rounded,
                          onTap: () => context.go("/home/personal_victories"),
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
                  colorScheme.primary.withOpacity(0.14),
                  colorScheme.surfaceContainerHighest.withOpacity(0.12),
                ],
              ),
            ),
            padding: const EdgeInsets.all(24),
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
                const SizedBox(height: 22),
                Text(
                  question,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                    letterSpacing: -0.6,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  answer,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.74),
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 22),
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
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: colorScheme.primary.withOpacity(0.06),
            ),
            child: Row(
              children: [
                Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: colorScheme.primary.withOpacity(0.12),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: onTap,
          child: Container(
            height: 160,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: colorScheme.surfaceContainerHighest.withOpacity(0.20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 46,
                  width: 46,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, size: 24, color: colorScheme.primary),
                ),
                const Spacer(),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.55),
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
              color: colorScheme.surfaceContainerHighest.withOpacity(0.16),
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
