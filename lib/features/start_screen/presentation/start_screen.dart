import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/features/intro/presentation/login_screen.dart';
import 'package:ruminate/features/intro/presentation/welcome_screen.dart';
import 'package:ruminate/features/start_screen/presentation/view_model/start_view_model.dart';

class StartScreen extends ConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startViewModel = ref.watch(startViewModelProvider);

    return Scaffold(
      body: startViewModel.when(
        data: (data) {
      
          return WelcomeScreen(data);
        },
        error: (e, stack) {
          return Container();
        },
        loading: () {
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
