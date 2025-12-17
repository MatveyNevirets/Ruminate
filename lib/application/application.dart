// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/application/routes.dart';
import 'package:ruminate/core/providers/start_provider.dart';
import 'package:ruminate/core/providers/theme_provider.dart';
import 'package:ruminate/features/start/providers/start_repository_provider.dart';

class Application extends ConsumerWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    final startFutureRepository = ref.watch(startDataProvider);

    return startFutureRepository.when(
      data: (data) {
        final routerConfig = ref.read(routerConfigProvider);

        return MaterialApp.router(
          theme: theme,
          debugShowCheckedModeBanner: false,
          routerConfig: routerConfig,
        );
      },
      error: (e, stack) {
        return Container();
      },
      loading: () {
        return CircularProgressIndicator();
      },
    );
  }
}
