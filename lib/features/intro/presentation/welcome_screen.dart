import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/widgets/page_shell_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      icon: Icons.psychology_alt_rounded,
      title: "Добро\nпожаловать",
      subtitle:
          "Ruminate — это личное пространство для глубокой саморефлексии, где мысли становятся яснее, а паттерны — заметнее.",
      primaryActionText: "Начать",
      onPrimaryAction: () {
        context.go("/onBoarding/before_start/");
      },
      child: const SizedBox.shrink(),
    );
  }
}
