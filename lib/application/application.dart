// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/providers/theme_provider.dart';
import 'package:ruminate/core/widgets/main_pages_widget.dart';
import 'package:ruminate/features/daily_reflection/presentation/daily_reflection_screen.dart';

class Application extends ConsumerWidget {
  Application({super.key});

  final _routerConfig = GoRouter(
    initialLocation: "/home",
    routes: [
      GoRoute(
        path: "/home",
        builder: (BuildContext context, state) => MainPagesWidget(),
        routes: [GoRoute(path: "/daily_reflection", builder: (context, state) => DailyReflectionScreen())],
      ),
    ],
  );

  final pageV = PageView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return MaterialApp.router(theme: theme, debugShowCheckedModeBanner: false, routerConfig: _routerConfig);
  }
}
