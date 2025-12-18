import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/data/model/reflection_model.dart';
import 'package:ruminate/core/enums/reflect_type_enum.dart';
import 'package:ruminate/core/widgets/main_pages_widget.dart';
import 'package:ruminate/core/widgets/string_list_screen.dart';
import 'package:ruminate/features/completed_reflections/presentation/completed_reflections_screen.dart';
import 'package:ruminate/features/completed_reflections/presentation/detail_completed_reflection_screen.dart';
import 'package:ruminate/features/intro/presentation/before_start_screen.dart';
import 'package:ruminate/features/intro/presentation/login_screen.dart';
import 'package:ruminate/features/intro/presentation/password_set_screen.dart';
import 'package:ruminate/features/intro/presentation/registration_screen.dart';
import 'package:ruminate/features/intro/presentation/welcome_screen.dart';
import 'package:ruminate/features/intro/presentation/where_change_password_screen.dart';
import 'package:ruminate/features/personal_victories/presentation/personal_victories_screen.dart';
import 'package:ruminate/features/reflection/presentation/providers/reflection_view_model_provider.dart';
import 'package:ruminate/features/reflection/presentation/reflection_screen.dart';
import 'package:ruminate/features/reflection/presentation/start_daily_reflection_screen.dart';
import 'package:ruminate/features/start/enum/start_state.dart';
import 'package:ruminate/features/start/presentation/view_model/start_view_model.dart';

final routerConfigProvider = Provider<GoRouter>((ref) {
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    final startState = ref.watch(startViewModelProvider);
    final currentLocation = state.matchedLocation;

    log("$currentLocation redirrreeect");

    switch (startState) {
      case StartState.onBoarding:
        if (currentLocation.startsWith("/onBoarding/")) {
          return null;
        }
        return "/onBoarding";

      case StartState.password:
        return "/password";

      case StartState.loading:
        return "/splash";

      case StartState.authenticated:
        if (currentLocation.startsWith("/home/")) {
          return null;
        } else {
          return "/home";
        }
    }
  }

  return GoRouter(
    redirect: redirect,
    initialLocation: "/splash",
    routes: [
      GoRoute(
        path: '/onBoarding',
        routes: [
          GoRoute(
            path: "/before_start",
            builder: (context, state) => BeforeStartScreen(),
            routes: [
              GoRoute(
                path: "/login",
                builder: (context, state) => LoginScreen(),
                routes: [
                  GoRoute(
                    path: "/registration",
                    builder: (context, state) => RegistrationScreen(),
                  ),
                  GoRoute(
                    path: "/password_set",
                    builder: (context, state) => PasswordSetScreen(),
                    routes: [
                      GoRoute(
                        path: "/where_change",
                        builder: (context, state) =>
                            WhereChangePasswordScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
        builder: (context, state) {
          return WelcomeScreen();
        },
      ),
      GoRoute(
        path: "/splash",
        builder: (context, state) =>
            Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      GoRoute(
        path: "/home",
        builder: (BuildContext context, state) => MainPagesWidget(),
        routes: [
          GoRoute(
            path: "/strings_list",
            builder: (context, state) {
              final extra = state.extra as List<Object?>;
              final strings = extra[0] as List<String?>;
              final title = extra[1] as String;
              return StringListScreen(strings: strings, title: title);
            },
          ),
          GoRoute(
            path: "/details",
            builder: (context, state) {
              final reflection = state.extra as ReflectionModel;
              return DetailCompletedReflectionScreen(reflection: reflection);
            },
          ),
          GoRoute(
            path: ("/personal_victories"),
            builder: (context, state) {
              return PersonalVictoriesScreen();
            },
          ),
          GoRoute(
            path: "/completed_reflections",
            builder: (context, state) {
              return CompletedReflectionsScreen();
            },
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
});
