import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/core/widgets/app_container.dart';
import 'package:ruminate/core/widgets/app_text_field.dart';
import 'package:ruminate/core/widgets/snack_bar.dart';
import 'package:ruminate/features/intro/presentation/view_model/password_view_model.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({super.key});

  @override
  ConsumerState<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen> {
  final passwordController = TextEditingController();
  bool _handled = false;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final passwordVM = ref.watch(passwordViewModelProvider.notifier);
    final passwordVMState = ref.watch(passwordViewModelProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_handled) return;

      passwordVMState.when(
        data: (data) {
          _handled = true;

          if (data) {
            showSnackBar(context, "Успешный вход!");
            context.go("/password/go_home");
          } else {
            showSnackBar(context, "Неверный пароль!");
            _handled = false;
          }
        },
        error: (e, s) {
          _handled = false;
        },
        loading: () {},
      );
    });

    return Scaffold(
      body: Stack(
        children: [
          /// BACKGROUND (rectangular glow like PageShell, but different shape)
          Positioned(
            top: -140,
            right: -120,
            child: Container(
              width: 320,
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48),
                color: colorScheme.primary.withOpacity(0.10),
              ),
            ),
          ),

          Positioned(
            bottom: -160,
            left: -140,
            child: Container(
              width: 360,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(64),
                color: colorScheme.primary.withOpacity(0.06),
              ),
            ),
          ),

          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: theme.extraLargePaddingDouble,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: theme.largePaddingDouble * 8,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: theme.mediumPaddingDouble),

                            /// TITLE
                            Text(
                              "С возвращением",
                              style: theme.textTheme.headlineLarge?.copyWith(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.w900,
                                height: 1.05,
                              ),
                            ),

                            SizedBox(height: theme.mediumPaddingDouble),

                            /// SUBTITLE
                            Text(
                              "Пять минут честности с собой экономят часы лишних действий.",
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onSurface.withOpacity(0.65),
                                height: 1.7,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            SizedBox(height: theme.largePaddingDouble * 1.5),

                            /// GLASS CARD
                            ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 14,
                                  sigmaY: 14,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color: colorScheme.surface.withOpacity(
                                      0.55,
                                    ),
                                    border: Border.all(
                                      color: colorScheme.outline.withOpacity(
                                        0.08,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppContainer(
                                        title: "Введите пароль",
                                        subtitle:
                                            "Он защитит твои заметки от посторонних глаз.",
                                        leading: Icon(
                                          Icons.lock_outline_rounded,
                                          color: colorScheme.primary,
                                        ),
                                      ),

                                      SizedBox(
                                        height: theme.mediumPaddingDouble,
                                      ),

                                      AppTextField(
                                        controller: passwordController,
                                        hintText: "Пароль",
                                        obscureText: true,
                                        prefixIcon: Icon(
                                          Icons.key_rounded,
                                          color: colorScheme.primary,
                                        ),
                                      ),

                                      SizedBox(
                                        height: theme.largePaddingDouble,
                                      ),

                                      AppButton(
                                        onClick: () {
                                          passwordVM.verifyPassword(
                                            passwordController.text.trim(),
                                          );
                                        },
                                        text: "Войти",
                                        icon: Icons.arrow_forward_rounded,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const Spacer(),

                            /// FOOTER
                            Padding(
                              padding: EdgeInsets.only(
                                top: theme.largePaddingDouble,
                                bottom:
                                    MediaQuery.of(context).padding.bottom + 20,
                              ),
                              child: Center(
                                child: Text(
                                  "Мы верим в твои силы.",
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurface.withOpacity(
                                      0.55,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
