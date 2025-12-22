import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/reflection/data/model/reflection_model.dart';
import 'package:ruminate/core/providers/navigation_providers.dart';
import 'package:ruminate/core/providers/reflection_datasource_repository_provider.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/utils/utils.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_container.dart';
import 'package:ruminate/core/widgets/bottom_navigation_bar.dart';
import 'package:ruminate/features/statistics/presentation/view_model/statistics_view_model.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  Future<List<ReflectionModel>?> fetchReflectionsAsFuture(WidgetRef ref) async {
    final reflectionsRepository = ref.watch(reflectionRepositoryProvider);
    final reflections = await reflectionsRepository.fetchAllReflections();

    return reflections;
  }

  List<int> getReflectionCounts(
    List<ReflectionModel>? reflections,
    List<int> weekdayInts,
  ) {
    List<int> reflectionsCounts = List.generate(7, (i) => 0);

    if (reflections != null) {
      for (int i = 0; i < weekdayInts.length; i++) {
        for (ReflectionModel reflection in reflections) {
          if (reflection.reflectionDate?.day == weekdayInts[i] &&
              reflection.reflectionDate?.month == DateTime.now().month) {
            reflectionsCounts[i] += 1;
          }
        }
      }
    }

    return reflectionsCounts;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationProvider = ref.watch(navigationViewModel.notifier);
    final navigationIndex = ref.watch(navigationViewModel);

    final state = ref.watch(statisticsViewModelProvider);
    final weekdayInts = Utils.convertStringsAsInt(Utils.getWeekdaysAsString());

    final theme = Theme.of(context);

    return Scaffold(
      appBar: createAppBar(context, title: "Статистика"),

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
                      FutureBuilder(
                        future: fetchReflectionsAsFuture(ref),
                        builder: (context, asyncSnapshot) {
                          if (asyncSnapshot.hasData ||
                              asyncSnapshot.data == null) {
                            final reflections = asyncSnapshot.data;

                            return AppChartWidget(
                              bottomInts: weekdayInts,
                              subtitle: "Статистика за текущую\nНеделю:",
                              title:
                                  "Рефлексии за всё время: ${data?.last.totalReflections ?? 0}",
                              columnsHeight: getReflectionCounts(
                                reflections,
                                weekdayInts,
                              ),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
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
                      Card(
                        color: theme.colorScheme.tertiary,
                        child: Stack(
                          children: [
                            Positioned(
                              height: MediaQuery.sizeOf(context).height / 2.5,
                              width: MediaQuery.sizeOf(context).width / 1.15,
                              child: Center(
                                child: Text(
                                  "Скоро",
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    color: theme.scaffoldBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                            Opacity(
                              opacity: 0.5,
                              child: AppChartWidget(
                                columnsHeight: [21, 2, 23, 1, 43, 2, 53, 5],
                                title: "Твой средний уровень уверенности\nN/10",
                              ),
                            ),
                          ],
                        ),
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
                                return statisticModel.fears;
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
  const AppChartWidget({
    super.key,
    required this.title,
    required this.columnsHeight,
    this.subtitle,
    this.bottomInts,
  });
  final String title;
  final String? subtitle;
  final List<int> columnsHeight;
  final List<int>? bottomInts;

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
                  const SizedBox(height: 5),
                  subtitle == null
                      ? Container()
                      : Text(
                          subtitle!,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                  const SizedBox(height: 35),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: BarChart(
                        mainBarData(theme, bottomInts: bottomInts),
                      ),
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
    int? x,
    ThemeData theme, {
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [2],
  }) {
    int maxHeight = 1;

    for (int i = 0; i < columnsHeight.length; i++) {
      if (maxHeight < columnsHeight[i]) {
        maxHeight = columnsHeight[i];
      }
    }

    return BarChartGroupData(
      x: x ?? 0,
      barRods: [
        BarChartRodData(
          color: theme.colorScheme.secondary,
          width: width,
          toY: y,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: maxHeight.toDouble(),
            color: theme.scaffoldBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(ThemeData theme) {
    return List.generate(
      columnsHeight.length,
      (i) => makeGroupData(
        columnsHeight[i].toDouble(),
        bottomInts == null ? null : bottomInts![i],
        theme,
      ),
    );
  }

  BarChartData mainBarData(ThemeData theme, {List<int?>? bottomInts}) {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => theme.colorScheme.primary,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem(
              ((rod.toY).toStringAsFixed(1)).toString(),
              TextStyle(
                color: theme.colorScheme.onPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            );
          },
        ),
      ),

      titlesData: FlTitlesData(
        show: bottomInts == null ? false : true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (double value, TitleMeta meta) {
              // Преобразуем числовое значение в текст дня недели
              String text = value.toInt().toString();
              return Padding(
                padding: theme.mediumPadding,
                child: Text(
                  text,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              );
            },
            reservedSize: 45, // Место для подписей
          ),
        ),
      ),

      borderData: FlBorderData(show: false),
      barGroups: showingGroups(theme),
      gridData: const FlGridData(show: false),
    );
  }
}
