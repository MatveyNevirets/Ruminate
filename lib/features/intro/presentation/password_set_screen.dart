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

  double _titleSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 360) return 28;
    if (width < 400) return 31;
    return 34;
  }

  double _subtitleSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 360) return 14.5;
    if (width < 400) return 15;
    return 16;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final startVM = ref.watch(startViewModelProvider.notifier);
    final passwordVM = ref.watch(passwordViewModelProvider.notifier);

    final isCompact = MediaQuery.sizeOf(context).width < 360;
    final horizontalPadding = isCompact
        ? theme.largePaddingDouble
        : theme.extraLargePaddingDouble;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: -120,
            right: -80,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primary.withOpacity(0.12),
              ),
            ),
          ),
          Positioned(
            bottom: -180,
            left: -120,
            child: Container(
              width: 340,
              height: 340,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primary.withOpacity(0.07),
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: isCompact
                                ? theme.smallPaddingDouble
                                : theme.mediumPaddingDouble,
                          ),
                          if (context.canPop()) ...[
                            const _BackButton(),
                            SizedBox(height: isCompact ? 28 : 36),
                          ] else ...[
                            SizedBox(height: isCompact ? 12 : 18),
                          ],
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 520),
                            child: Text(
                              "Личное —\nне публичное",
                              style: theme.textTheme.headlineLarge?.copyWith(
                                fontSize: _titleSize(context),
                                height: 1.0,
                                letterSpacing: -1.2,
                                fontWeight: FontWeight.w900,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                          SizedBox(height: isCompact ? 14 : 18),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 540),
                            child: Text(
                              "Чтобы рефлексии были только у тебя, можешь установить пароль.",
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onSurface.withOpacity(0.66),
                                height: 1.62,
                                fontSize: _subtitleSize(context),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: isCompact ? 28 : 34),

                          _InputSection(
                            title: "Придумай пароль",
                            controller: firstPasswordController,
                            hintText: "Введите пароль",
                            icon: Icons.lock_outline_rounded,
                          ),
                          SizedBox(height: theme.mediumPaddingDouble),
                          _InputSection(
                            title: "Повтори пароль",
                            controller: secondPasswordController,
                            hintText: "Повторите пароль",
                            icon: Icons.lock_reset_rounded,
                          ),
                          SizedBox(height: isCompact ? 28 : 36),
                          AppButton(
                            onClick: () async {
                              final first = firstPasswordController.text.trim();
                              final second = secondPasswordController.text
                                  .trim();

                              startVM.setFirstEnter(false);

                              if (first.isEmpty || second.isEmpty) {
                                showSnackBar(
                                  context,
                                  "Заполни оба поля",
                                  duration: Durations.long3,
                                );
                                return;
                              }

                              if (first == second) {
                                await passwordVM.setPassword(first);
                                await startVM.setHavePassword(true);

                                if (!context.mounted) return;

                                showSnackBar(
                                  context,
                                  "Пароль успешно установлен!",
                                );

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
                              child: Text(
                                "Продолжить без пароля",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.onSurface.withOpacity(
                                    0.62,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: isCompact ? 14 : 18),
                          Center(
                            child: Text(
                              "Пароль можно изменить позже в профиле.",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurface.withOpacity(0.55),
                                height: 1.45,
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
        ],
      ),
    );
  }
}

class _InputSection extends StatelessWidget {
  const _InputSection({
    required this.title,
    required this.controller,
    required this.hintText,
    required this.icon,
  });

  final String title;
  final TextEditingController controller;
  final String hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.outline.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            offset: const Offset(0, 10),
            color: Colors.black.withOpacity(0.04),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: colorScheme.primary.withOpacity(0.10),
                ),
                child: Icon(icon, color: colorScheme.primary, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Надёжный пароль лучше хранить в менеджере паролей.",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.58),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          AppTextField(
            controller: controller,
            hintText: hintText,
            obscureText: true,
            prefixIcon: Icon(
              Icons.key_rounded,
              color: colorScheme.onSurface.withOpacity(0.42),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => context.pop(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: colorScheme.surface.withOpacity(0.55),
              border: Border.all(color: colorScheme.outline.withOpacity(0.08)),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
