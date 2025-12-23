// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/application/routes.dart';
import 'package:ruminate/core/providers/start_provider.dart';
import 'package:ruminate/core/view_models/theme_view_model.dart';

class Application extends ConsumerWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startFutureRepository = ref.read(startDataProvider);
    final theme = ref.watch(themeProvider);

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
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
