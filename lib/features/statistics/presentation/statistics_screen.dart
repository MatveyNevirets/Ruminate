import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/providers/navigation_providers.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_container.dart';
import 'package:ruminate/core/widgets/bottom_navigation_bar.dart';
import 'package:ruminate/features/statistics/data/models/statistics_model.dart';
import 'package:ruminate/features/statistics/presentation/view_model/statistics_view_model.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationProvider = ref.watch(navigationViewModel.notifier);
    final navigationIndex = ref.watch(navigationViewModel);

    final statisticsViewModel = ref.watch(statisticsViewModelProvider.notifier);
    final state = ref.watch(statisticsViewModelProvider);

    final theme = Theme.of(context);

    return Scaffold(
      appBar: createAppBar(context),

      body: state.when(
        data: (data) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: theme.largePadding,
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Статистика рефлексий',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: theme.largePaddingDouble),
                      AppChartWidget(
                        title:
                            "Рефлексии за всё время: ${data?.last.totalReflections ?? 0}",
                        anyData: List.generate(7, (i) => ""),
                      ),
                      SizedBox(height: theme.largePaddingDouble),
                      Text(
                        'Всего личных побед: ${data?.last.totalVictories ?? 0}',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: theme.extraLargePaddingDouble),
                      SizedBox(
                        height: 1.5,
                        width: double.maxFinite,
                        child: ColoredBox(color: theme.colorScheme.primary),
                      ),
                      SizedBox(height: theme.extraLargePaddingDouble),
                      Text(
                        'Энергия',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: theme.largePaddingDouble),
                      Row(
                        children: [
                          Expanded(
                            child: AppContainer(
                              title: "Генераторы твоей\nэнергии",
                              onClick: () => context.go(
                                "/home/strings_list",
                                extra: [
                                  data?.map((statisticModel) {
                                    if (statisticModel.energyGenerators !=
                                        null) {
                                      return statisticModel.energyGenerators;
                                        }
                                  }).toList(),
                                  "Ты получил(а) энергию благодаря: ",
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: AppContainer(
                              title: "Черные дыры твоей\nэнергии",
                              onClick: () => context.go(
                                "/home/strings_list",
                                extra: [
                                  data?.map((statisticModel) {
                                    if (statisticModel.energyKillers != null) {
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
                      SizedBox(height: theme.extraLargePaddingDouble),

                      SizedBox(
                        height: 1.5,
                        width: double.maxFinite,
                        child: ColoredBox(color: theme.colorScheme.primary),
                      ),
                      SizedBox(height: theme.extraLargePaddingDouble),

                      Text(
                        'На улучшение',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: theme.largePaddingDouble),
                      AppContainer(
                        title: "Важно над этим поработать",
                        onClick: () => context.go(
                          "/home/strings_list",
                          extra: [
                            data?.map((statisticModel) {
                              if (statisticModel.importantToWork != null) {
                                return statisticModel.importantToWork;
                              } 
                            }).toList(),
                            "Ты отмечал(а), что хотел(а) бы над этим поработать:",
                          ],
                        ),
                      ),
                      SizedBox(height: theme.largePaddingDouble),
                      AppChartWidget(
                        anyData: List.generate(32, (i) => ""),
                        title: "Твой средний уровень уверенности\nN/10",
                      ),
                      SizedBox(height: theme.largePaddingDouble),
                      Text(
                        'Нам всем бывает страшно',
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      AppContainer(
                        title: "Все твои страхи",
                        onClick: () => context.go(
                          "/home/strings_list",
                          extra: [
                            data?.map((statisticModel) {
                              if (statisticModel.fears != null) {
                              return  statisticModel.fears;
                              }
                            }).toList(),
                            "Подумай что ты можешь сделать со своими страхами:",
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        error: (Object error, StackTrace stackTrace) {
          return null;
        },
        loading: () {
          return Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: createBottomNavigationBar(
        context,
        navigationProvider,
        navigationIndex,
      ),
    );
  }
}

class AppChartWidget extends StatelessWidget {
  const AppChartWidget({super.key, required this.title, required this.anyData});
  final String title;
  final List<dynamic> anyData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.primaryContainer,
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            Padding(
              padding: theme.largePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 38),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: BarChart(mainBarData(theme)),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    double y,
    ThemeData theme, {
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [2],
  }) {
    return BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
          color: theme.colorScheme.secondary,
          width: width,
          toY: y,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 100,
            color: theme.scaffoldBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(ThemeData theme) =>
      List.generate(anyData.length, (i) => makeGroupData((i + 1) * 3, theme));

  BarChartData mainBarData(ThemeData theme) {
    return BarChartData(
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      barGroups: showingGroups(theme),
      gridData: const FlGridData(show: false),
    );
  }
}
