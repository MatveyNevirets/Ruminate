import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/features/start/presentation/view_model/start_view_model.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen(
  // this.startData,
  {super.key});
  // List<bool> startData;

  // late final isFirstEnter = widget.startData[0];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startProvider = ref.watch(startViewModelProvider.notifier);

    return Scaffold(
      body: Column(
        children: [
          Text("Welcome"),
          AppButton(
            onClick: () => startProvider.setFirstEnter(false),
            text: "дальше",
          ),
        ],
      ),
    );
  }
}
