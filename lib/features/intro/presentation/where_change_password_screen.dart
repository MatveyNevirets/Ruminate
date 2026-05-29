import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/widgets/page_shell_widget.dart';

class WhereChangePasswordScreen extends StatelessWidget {
  const WhereChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      icon: Icons.shield_rounded,
      title: "Пароль\nпод контролем",
      subtitle:
          "Ты всегда можешь изменить или удалить пароль в разделе «Профиль».",
      primaryActionText: "Продолжить",
      onPrimaryAction: () {
        context.go(
          "/onBoarding/before_start/password_set/where_change/go_home",
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
