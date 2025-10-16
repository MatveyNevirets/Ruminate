import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/providers/page_controller_provider.dart';
import 'package:ruminate/features/home/presentation/home_screen.dart';

class MainPagesWidget extends ConsumerWidget {
  const MainPagesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageNotifierProvider = ref.watch(pageProvider.notifier);

    return PageView(
      controller: pageNotifierProvider.pageController,
      onPageChanged: (ints) {
        log("$ints");
      },
      children: [
        HomeScreen(),
        Scaffold(body: Center(child: Text("1"))),
        Scaffold(body: Center(child: Text("2"))),
      ],
    );
  }
}
