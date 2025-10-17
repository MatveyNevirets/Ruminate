import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/widgets/main_pages_widget.dart';
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
            GoRoute(path: "/indepth_reflection", builder: (context, state) => Container()),
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
