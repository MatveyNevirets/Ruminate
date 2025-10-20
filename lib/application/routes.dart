import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/widgets/main_pages_widget.dart';
import 'package:ruminate/features/daily_reflection/presentation/indepth/indepth_difficults_screen.dart';
import 'package:ruminate/features/daily_reflection/presentation/indepth/indepth_energy_screen.dart';
import 'package:ruminate/features/daily_reflection/presentation/indepth/indepth_review_screen.dart';
import 'package:ruminate/features/daily_reflection/presentation/indepth/indepth_thanks_screen.dart';
import 'package:ruminate/features/daily_reflection/presentation/indepth/indepth_todo_screen.dart';
import 'package:ruminate/features/daily_reflection/presentation/indepth/indepth_wins_screen.dart';
import 'package:ruminate/features/daily_reflection/presentation/start_daily_reflection_screen.dart';
import 'package:ruminate/features/daily_reflection/presentation/superficial/superficial_grow_screen.dart';
import 'package:ruminate/features/daily_reflection/presentation/superficial/superficial_review_screen.dart';
import 'package:ruminate/features/daily_reflection/presentation/superficial/superficial_state_screen.dart';
import 'package:ruminate/features/daily_reflection/presentation/superficial/superficial_wins_screen.dart';

final routerConfig = GoRouter(
  initialLocation: "/home",
  routes: [
    GoRoute(
      path: "/home",
      builder: (BuildContext context, state) => MainPagesWidget(),
      routes: [
        GoRoute(
          path: "/daily_reflection",
          builder: (context, state) => StartDailyReflectionScreen(),
          routes: [
            GoRoute(
              path: "/indepth_reflection",
              builder: (context, state) => IndepthReviewScreen(),
              routes: [
                GoRoute(
                  path: "/energy",
                  builder: (context, state) => IndepthEnergyScreen(),
                  routes: [
                    GoRoute(
                      path: "/wins",
                      builder: (context, state) => IndepthWinsScreen(),
                      routes: [
                        GoRoute(
                          path: "/difficults",
                          builder: (context, state) => IndepthDifficultsScreen(),
                          routes: [
                            GoRoute(
                              path: "/todo",
                              builder: (context, state) => IndepthTodoScreen(),
                              routes: [GoRoute(path: "/thanks", builder: (context, state) => IndepthThanksScreen())],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              path: "/superficial_reflection",
              builder: (context, state) => SuperficialReviewScreen(),
              routes: [
                GoRoute(
                  path: "/wins",
                  builder: (context, state) => SuperficialWinsScreen(),
                  routes: [
                    GoRoute(
                      path: "/grow",
                      builder: (context, state) => SuperficialGrowScreen(),
                      routes: [GoRoute(path: "/state", builder: (context, state) => SuperficialStateScreen())],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
