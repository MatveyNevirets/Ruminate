import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/utils/utils.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/core/widgets/app_container.dart';
import 'package:ruminate/core/widgets/app_text_field.dart';
import 'package:ruminate/core/widgets/snack_bar.dart';
import 'package:ruminate/features/intro/presentation/view_model/password_view_model.dart';
import 'package:ruminate/features/start/presentation/view_model/start_view_model.dart';

class PasswordSetScreen extends ConsumerStatefulWidget {
  const PasswordSetScreen({super.key});

  @override
  ConsumerState<PasswordSetScreen> createState() => _PasswordSetScreenState();
}

class _PasswordSetScreenState extends ConsumerState<PasswordSetScreen> {
  final firstPasswordController = TextEditingController();
  final secondPasswordController = TextEditingController();

  @override
  void dispose() {
    firstPasswordController.dispose();
    secondPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final startVM = ref.watch(startViewModelProvider.notifier);
    final passwordVM = ref.watch(passwordViewModelProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: theme.extraLargePaddingDouble,
                    vertical: theme.extraLargePaddingDouble,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Личное —\nне публичное",
                        style: theme.textTheme.headlineLarge?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      SizedBox(height: theme.mediumPaddingDouble),

                      Text(
                        "Чтобы рефлексии были только у тебя, можешь установить пароль.",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.68),
                          height: 1.6,
                        ),
                      ),

                      SizedBox(height: theme.largePaddingDouble),

                      AppContainer(
                        height: MediaQuery.sizeOf(context).height / 8,
                        title: "Пароль",
                        subtitle: "Придумай удобную, но безопасную комбинацию.",
                        leading: Icon(
                          Icons.password_rounded,
                          color: theme.colorScheme.primary,
                        ),
                      ),

                      SizedBox(height: theme.largePaddingDouble * 2),

                      AppTextField(
                        controller: firstPasswordController,
                        hintText: "Введите пароль",
                        obscureText: true,
                      ),

                      SizedBox(height: theme.mediumPaddingDouble),

                      AppTextField(
                        controller: secondPasswordController,
                        hintText: "Повторите пароль",
                        obscureText: true,
                      ),

                      SizedBox(height: theme.largePaddingDouble * 2),

                      AppButton(
                        onClick: () async {
                          final first = firstPasswordController.text;
                          final second = secondPasswordController.text;

                          startVM.setFirstEnter(false);

                          if (first == second) {
                            await passwordVM.setPassword(first);
                            await startVM.setHavePassword(true);

                            if (!context.mounted) return;

                            showSnackBar(context, "Пароль успешно установлен!");

                            context.go(
                              "/onBoarding/before_start/password_set/where_change/",
                            );
                          } else {
                            firstPasswordController.clear();
                            secondPasswordController.clear();

                            showSnackBar(
                              context,
                              "Пароли должны совпадать!",
                              duration: Durations.long3,
                            );
                          }
                        },
                        text: "Установить пароль",
                        icon: Icons.verified_rounded,
                      ),

                      SizedBox(height: theme.mediumPaddingDouble),

                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () async {
                            await startVM.setFirstEnter(false);

                            if (!context.mounted) return;

                            context.go(
                              "/onBoarding/before_start/password_set/where_change/",
                            );
                          },
                          child: const Text("Продолжить без пароля"),
                        ),
                      ),

                      SizedBox(height: theme.largePaddingDouble),

                      Center(
                        child: Text(
                          "Пароль можно изменить позже в профиле.",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(
                              0.55,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: theme.largePaddingDouble),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
