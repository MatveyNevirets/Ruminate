import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/providers/navigation_providers.dart';
import 'package:ruminate/core/widgets/bottom_navigation_bar.dart';
import 'package:ruminate/features/home/presentation/home_screen.dart';
import 'package:ruminate/features/profile/presentation/profile_screen.dart';
import 'package:ruminate/features/statistics/presentation/statistics_screen.dart';

class MainPagesWidget extends ConsumerWidget {
  const MainPagesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(pageControllerProvider);

    return PageView(
      controller: controller,
      children: [HomeScreen(), StatisticsScreen(), ProfileScreen()],
    );
  }
}
