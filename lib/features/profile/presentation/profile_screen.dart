import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/providers/navigation_providers.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/bottom_navigation_bar.dart';
import 'package:ruminate/features/obsidian_sync/presentation/widgets/obsidian_sync_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationProvider = ref.watch(navigationViewModel.notifier);
    final navigationIndex = ref.watch(navigationViewModel);

    return Scaffold(
      appBar: createAppBar(context),
      body: Center(child: ObsidianSyncButton()),
      bottomNavigationBar: createBottomNavigationBar(
        context,
        navigationProvider,
        navigationIndex,
      ),
    );
  }
}
