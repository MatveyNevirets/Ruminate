import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/data/model/reflection_model.dart';
import 'package:ruminate/core/enums/reflect_type_enum.dart';
import 'package:ruminate/core/widgets/main_pages_widget.dart';
import 'package:ruminate/features/completed_reflections/presentation/completed_reflections_screen.dart';
import 'package:ruminate/features/completed_reflections/presentation/detail_completed_reflection_screen.dart';
import 'package:ruminate/features/reflection/presentation/providers/reflection_view_model_provider.dart';
import 'package:ruminate/features/reflection/presentation/reflection_screen.dart';
import 'package:ruminate/features/reflection/presentation/start_daily_reflection_screen.dart';

final routerConfig = GoRouter(
  initialLocation: "/home",
  routes: [
    GoRoute(
      path: "/home",
      builder: (BuildContext context, state) => MainPagesWidget(),
      routes: [
        GoRoute(
          path: "/completed_reflections",
          builder: (context, state) {
            return CompletedReflectionsScreen();
          },
          routes: [
            GoRoute(
              path: "/details",
              builder: (context, state) {
                final reflection = state.extra as ReflectionModel;
                return DetailCompletedReflectionScreen(reflection: reflection);
              },
            ),
          ],
        ),
        GoRoute(
          path: "/month_reflection",
          builder: (context, state) {
            return Consumer(
              builder: (context, ref, child) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  final viewModel = ref.watch(reflectionVM.notifier);
                  viewModel.setType(ReflectType.monthly);
                });

                return ReflectionScreen();
              },
            );
          },
        ),
        GoRoute(
          path: "/daily_reflection",
          builder: (context, state) => StartDailyReflectionScreen(),
          routes: [
            GoRoute(
              path: "/indepth_reflection",
              builder: (context, state) {
                return Consumer(
                  builder: (context, ref, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      final viewModel = ref.watch(reflectionVM.notifier);
                      viewModel.setType(ReflectType.dailyIndepth);
                    });

                    return ReflectionScreen();
                  },
                );
              },
            ),

            GoRoute(
              path: "/superficial_reflection",
              builder: (context, state) {
                return Consumer(
                  builder: (context, ref, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      final viewModel = ref.watch(reflectionVM.notifier);
                      viewModel.setType(ReflectType.dailySuperficital);
                    });

                    return ReflectionScreen();
                  },
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
