import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/providers/navigation_providers.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/utils/utils.dart';
import 'package:ruminate/core/view_models/you_thought_view_model.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_container.dart';
import 'package:ruminate/core/widgets/bottom_navigation_bar.dart';

// ignore: must_be_immutable
class YouThoughtSliverWidget extends StatefulWidget {
  YouThoughtSliverWidget({
    super.key,
    required this.youThoughtList,
    required this.youThoughtVM,
  });

  List<dynamic> youThoughtList;
  YouThoughtViewModel youThoughtVM;

  @override
  State<YouThoughtSliverWidget> createState() => _YouThoughtSliverWidgetState();
}

class _YouThoughtSliverWidgetState extends State<YouThoughtSliverWidget> {
  final _youThoughtKey = GlobalKey();
  double? expandedHeight;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox? renderBox =
          _youThoughtKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null && mounted) {
        setState(() {
          expandedHeight = renderBox.size.height;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    log(expandedHeight.toString());

    return SliverPadding(
      padding: theme.largePadding,
      sliver: SliverAppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        expandedHeight: expandedHeight ?? 200,
        flexibleSpace: AppContainer(
          key: _youThoughtKey,
          onClick: () =>
              context.go("/home/details/", extra: widget.youThoughtList[0]),
          title:
              "${Utils.fetchTextDateFromReflection(widget.youThoughtVM.reflection!)} ты отвечал на вопрос: ${Utils.cutStringByChars(widget.youThoughtList[1]?.keys.first, 40)}\nДата: ${Utils.fetchDateFromReflection(widget.youThoughtVM.reflection!)}\nТвой ответ: ${Utils.cutStringByChars(widget.youThoughtList[1].values.first.toString(), 40)}",
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
    // final appBarExpandedHeight = MediaQuery.of(context).size.height / 3.5;

    return Scaffold(
      appBar: createAppBar(context, title: "Ruminate"),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            youThought.when(
              loading: () => SliverToBoxAdapter(child: Container()),
              error: (e, stack) {
                return SliverPadding(
                  padding: theme.largePadding,

                  sliver: SliverToBoxAdapter(
                    child: AppContainer(title: "Что-то пошло не так :("),
                  ),
                );
              },
              data: (youThoughtList) {
                log(youThoughtList.toString());
                return youThoughtList == null
                    ? SliverToBoxAdapter(child: Container())
                    : YouThoughtSliverWidget(
                        youThoughtList: youThoughtList,
                        youThoughtVM: youThoughtVM,
                      );
              },
            ),

            SliverPadding(
              padding: theme.largePadding,
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Рефлексируй!",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: Theme.of(context).mediumPaddingDouble),
                    Row(
                      children: [
                        Expanded(
                          child: AppContainer(
                            title: "Ежедневная рефлексия",
                            onClick: () => context.go("/home/daily_reflection"),
                          ),
                        ),
                        SizedBox(width: Theme.of(context).mediumPaddingDouble),
                        Expanded(
                          child: AppContainer(title: "Создать рефлексию"),
                        ),
                      ],
                    ),
                    SizedBox(height: Theme.of(context).mediumPaddingDouble),
                    SizedBox(
                      width: double.maxFinite,
                      child: AppContainer(
                        title: "Ежемесячная рефлексия",
                        onClick: () => context.go("/home/month_reflection/"),
                      ),
                    ),
                    SizedBox(height: Theme.of(context).largePaddingDouble),
                    Text(
                      "Вспомни!",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: Theme.of(context).mediumPaddingDouble),
                    Row(
                      children: [
                        Expanded(
                          child: AppContainer(
                            title: "Все рефлексии",
                            onClick: () =>
                                context.go("/home/completed_reflections"),
                          ),
                        ),
                        SizedBox(width: Theme.of(context).mediumPaddingDouble),
                        Expanded(
                          child: AppContainer(
                            title: "Неделю назад ты думал о..",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Theme.of(context).mediumPaddingDouble),
                    SizedBox(
                      width: double.maxFinite,
                      child: AppContainer(
                        title: "Личные победы",
                        onClick: () => context.go("/home/personal_victories"),
                      ),
                    ),
                    SizedBox(height: Theme.of(context).largePaddingDouble),
                  ],
                ),
              ),
            ),
          ],
          scrollDirection: Axis.vertical,
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
