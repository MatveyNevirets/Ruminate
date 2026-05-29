import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/widgets/page_shell_widget.dart';

class BeforeStartScreen extends StatelessWidget {
  const BeforeStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      icon: Icons.lock_outline_rounded,
      title: "Перед тем\nкак начать",
      subtitle:
          "Данные хранятся только на устройстве. Удаление приложения удалит и записи. Экспорт в Obsidian доступен позже в профиле.",
      primaryActionText: "Понятно",
      onPrimaryAction: () {
        context.go("/onBoarding/before_start/password_set/");
      },
      child: const SizedBox.shrink(),
    );
  }
}
