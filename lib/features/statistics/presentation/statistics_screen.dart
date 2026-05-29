import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/providers/navigation_providers.dart';
import 'package:ruminate/core/providers/reflection_datasource_repository_provider.dart';
import 'package:ruminate/core/reflection/data/model/reflection_model.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_container.dart';
import 'package:ruminate/core/widgets/bottom_navigation_bar.dart';
import 'package:ruminate/features/statistics/presentation/view_model/statistics_view_model.dart';

class StatisticsScreen extends ConsumerStatefulWidget {
  const StatisticsScreen({super.key});

  @override
  ConsumerState<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends ConsumerState<StatisticsScreen> {
  late final Future<List<ReflectionModel>?> _reflectionsFuture;

  @override
  void initState() {
    super.initState();
    _reflectionsFuture = _fetchReflections();
  }

  Future<List<ReflectionModel>?> _fetchReflections() async {
    final repo = ref.read(reflectionRepositoryProvider);
    return repo.fetchAllReflections();
  }

  List<int> _getWeeklyReflectionCounts(List<ReflectionModel>? reflections) {
    final result = List<int>.filled(7, 0);

    if (reflections == null) {
      return result;
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7));

    for (final reflection in reflections) {
      final date = reflection.reflectionDate;
      if (date == null) continue;

      final normalized = DateTime(date.year, date.month, date.day);
      if (normalized.isBefore(startOfWeek) || !normalized.isBefore(endOfWeek)) {
        continue;
      }

      final index = normalized.weekday - 1;
      if (index >= 0 && index < 7) {
        result[index] += 1;
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = ref.watch(navigationViewModel.notifier);
    final navigationIndex = ref.watch(navigationViewModel);
    final state = ref.watch(statisticsViewModelProvider);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final weekdayLabels = const ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];

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
                SliverPadding(
                  padding: theme.largePadding.copyWith(top: 6, bottom: 0),
                  sliver: SliverToBoxAdapter(
                    child: _TopHeader(
                      title: "Статистика",
                      subtitle:
                          "Тихий разбор твоих мыслей, энергии и повторяющихся паттернов.",
                      chipText: "Insights",
                    ),
                  ),
                ),
                state.when(
                  loading: () => const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  error: (error, stackTrace) {
                    return SliverPadding(
                      padding: theme.largePadding,
                      sliver: SliverToBoxAdapter(
                        child: _SurfaceCard(
                          child: _StatusCard(
                            icon: Icons.error_outline_rounded,
                            title: "Не удалось загрузить статистику",
                            subtitle:
                                "Попробуй обновить экран или зайти чуть позже.",
                            accent: colorScheme.error,
                          ),
                        ),
                      ),
                    );
                  },
                  data: (data) {
                    final last = (data != null && data.isNotEmpty)
                        ? data.last
                        : null;

                    return SliverPadding(
                      padding: theme.largePadding.copyWith(top: 10),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder<List<ReflectionModel>?>(
                              future: _reflectionsFuture,
                              builder: (context, snapshot) {
                                final reflections = snapshot.data;
                                final counts = _getWeeklyReflectionCounts(
                                  reflections,
                                );

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return _SurfaceCard(
                                    accent: colorScheme.primary,
                                    child: const SizedBox(
                                      height: 280,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  );
                                }

                                return _ChartCard(
                                  title:
                                      "Рефлексии за всё время: ${last?.totalReflections ?? 0}",
                                  subtitle: "Статистика за текущую неделю",
                                  bottomLabels: weekdayLabels,
                                  columnsHeight: counts,
                                );
                              },
                            ),

                            SizedBox(height: theme.mediumPaddingDouble),

                            _MiniMetricCard(
                              title: "Всего личных побед",
                              value: "${last?.totalVictories ?? 0}",
                              icon: Icons.workspace_premium_rounded,
                              accent: colorScheme.primary,
                            ),

                            SizedBox(height: theme.largePaddingDouble * 1.25),

                            _SectionTitle(
                              title: "Энергия",
                              subtitle:
                                  "Что наполняет тебя и что забирает силы.",
                            ),

                            SizedBox(height: theme.mediumPaddingDouble),

                            Row(
                              children: [
                                Expanded(
                                  child: AppContainer(
                                    title: "Генераторы твоей\nэнергии",
                                    subtitle:
                                        "Что чаще всего давало тебе ресурс.",
                                    leading: _CardIcon(
                                      icon: Icons.bolt_rounded,
                                      color: colorScheme.primary,
                                    ),
                                    onClick: () => context.go(
                                      "/home/strings_list",
                                      extra: [
                                        data?.map((statisticModel) {
                                          if (statisticModel.energyGenerators !=
                                              null) {
                                            return statisticModel
                                                .energyGenerators;
                                          }
                                        }).toList(),
                                        "Ты получил(а) энергию благодаря:",
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: theme.mediumPaddingDouble),
                                Expanded(
                                  child: AppContainer(
                                    title: "Черные дыры твоей\nэнергии",
                                    subtitle: "Что чаще всего вытягивало силы.",
                                    leading: _CardIcon(
                                      icon: Icons.remove_circle_outline_rounded,
                                      color: colorScheme.primary,
                                    ),
                                    onClick: () => context.go(
                                      "/home/strings_list",
                                      extra: [
                                        data?.map((statisticModel) {
                                          if (statisticModel.energyKillers !=
                                              null) {
                                            return statisticModel.energyKillers;
                                          }
                                        }).toList(),
                                        "Эти вещи больше всего забирали твою энергию:",
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: theme.largePaddingDouble * 1.25),

                            _SectionTitle(
                              title: "На улучшение",
                              subtitle:
                                  "Точки роста, на которые стоит посмотреть внимательнее.",
                            ),

                            SizedBox(height: theme.mediumPaddingDouble),

                            AppContainer(
                              title: "Важно над этим поработать",
                              subtitle:
                                  "Список вещей, которые ты сам(а) выделял(а) как важные.",
                              leading: _CardIcon(
                                icon: Icons.trending_up_rounded,
                                color: colorScheme.primary,
                              ),
                              onClick: () => context.go(
                                "/home/strings_list",
                                extra: [
                                  data?.map((statisticModel) {
                                    if (statisticModel.importantToWork !=
                                        null) {
                                      return statisticModel.importantToWork;
                                    }
                                  }).toList(),
                                  "Ты отмечал(а), что хотел(а) бы над этим поработать:",
                                ],
                              ),
                            ),

                            SizedBox(height: theme.largePaddingDouble),

                            // _SoonCard(
                            //   title: "Твой средний уровень уверенности",
                            //   subtitle: "N/10",
                            // ),

                            // SizedBox(height: theme.largePaddingDouble),
                            _SectionTitle(
                              title: "Нам всем бывает страшно",
                              subtitle:
                                  "Страхи тоже можно видеть, называть и разбирать.",
                            ),

                            SizedBox(height: theme.mediumPaddingDouble),

                            AppContainer(
                              title: "Все твои страхи",
                              subtitle:
                                  "Посмотри на то, что тебя тревожит, без лишнего давления.",
                              leading: _CardIcon(
                                icon: Icons.shield_outlined,
                                color: colorScheme.primary,
                              ),
                              onClick: () => context.go(
                                "/home/strings_list",
                                extra: [
                                  data?.map((statisticModel) {
                                    if (statisticModel.fears != null) {
                                      return statisticModel.fears;
                                    }
                                  }).toList(),
                                  "Подумай, что ты можешь сделать со своими страхами:",
                                ],
                              ),
                            ),

                            SizedBox(height: theme.largePaddingDouble * 2),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopHeader extends StatelessWidget {
  const _TopHeader({
    required this.title,
    required this.subtitle,
    required this.chipText,
  });

  final String title;
  final String subtitle;
  final String chipText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.6,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.6),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        _MiniStatusChip(text: chipText, color: colorScheme.primary),
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
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({
    required this.title,
    required this.subtitle,
    required this.columnsHeight,
    required this.bottomLabels,
  });

  final String title;
  final String subtitle;
  final List<int> columnsHeight;
  final List<String> bottomLabels;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _SurfaceCard(
      accent: colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.6),
                height: 1.45,
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(height: 240, child: BarChart(_buildBarData(theme))),
          ],
        ),
      ),
    );
  }

  double _maxValue() {
    if (columnsHeight.isEmpty) return 1;
    var maxValue = columnsHeight.first;
    for (final value in columnsHeight) {
      if (value > maxValue) maxValue = value;
    }
    return maxValue.toDouble();
  }

  BarChartData _buildBarData(ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final maxY = _maxValue() + 1;

    return BarChartData(
      maxY: maxY,
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      alignment: BarChartAlignment.spaceAround,
      barTouchData: BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          tooltipPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          tooltipMargin: 10,
          getTooltipColor: (_) => colorScheme.primary,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              rod.toY.toStringAsFixed(0),
              TextStyle(
                color: colorScheme.onPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index < 0 || index >= bottomLabels.length) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  bottomLabels[index],
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.55),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      barGroups: List.generate(
        columnsHeight.length,
        (index) => BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: columnsHeight[index].toDouble(),
              width: 18,
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                toY: maxY,
                color: colorScheme.surfaceContainerHighest.withOpacity(0.32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniMetricCard extends StatelessWidget {
  const _MiniMetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.accent,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: accent.withOpacity(0.08),
        border: Border.all(color: accent.withOpacity(0.10)),
      ),
      child: Row(
        children: [
          Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: accent.withOpacity(0.12),
            ),
            child: Icon(icon, color: accent, size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface.withOpacity(0.62),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
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

class _SoonCard extends StatelessWidget {
  const _SoonCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: colorScheme.tertiary.withOpacity(0.12),
        border: Border.all(color: colorScheme.tertiary.withOpacity(0.18)),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            offset: const Offset(0, 10),
            color: Colors.black.withOpacity(0.03),
          ),
        ],
      ),
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
              color: colorScheme.onSurface.withOpacity(0.62),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: colorScheme.surface.withOpacity(0.55),
              border: Border.all(
                color: colorScheme.onSurface.withOpacity(0.06),
              ),
            ),
            child: Center(
              child: Text(
                "Скоро",
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.5),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
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

class _CardIcon extends StatelessWidget {
  const _CardIcon({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: 46,
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, color: color, size: 24),
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
