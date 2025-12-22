import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/core/widgets/app_text_field.dart';
import 'package:ruminate/core/widgets/snack_bar.dart';
import 'package:ruminate/features/intro/presentation/view_model/password_view_model.dart';

class PasswordScreen extends ConsumerWidget {
  PasswordScreen({super.key});

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final passwordVM = ref.watch(passwordViewModelProvider.notifier);
    final passwordVMState = ref.watch(passwordViewModelProvider);

    passwordVMState.when(
      data: (data) {
        if (data) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showSnackBar(context, "Успешный вход!");
            context.go("/password/go_home");
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showSnackBar(context, "Неверный пароль!");
          });
        }
      },
      error: (Object e, StackTrace stack) {
        throw Exception("$e StackTrace: $stack");
      },
      loading: () {},
    );

    return Scaffold(
      appBar: createAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.extraLargePaddingDouble,
            vertical: theme.extraLargePaddingDouble,
          ),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height / 1.25,
            width: MediaQuery.sizeOf(context).height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "С возвращением!",
                  textAlign: TextAlign.start,
                  style: theme.textTheme.headlineLarge!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: theme.largePaddingDouble),
                Text(
                  '''Пять минут честности с собой сэкономят тебе пять часов пустых действий''',
                  style: theme.textTheme.headlineSmall!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                Expanded(flex: 5, child: SizedBox()),
                Text(
                  '''Введите пароль''',
                  style: theme.textTheme.headlineSmall!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),

                AppTextField(controller: passwordController),

                Expanded(flex: 2, child: SizedBox()),
                AppButton(
                  onClick: () {
                    passwordVM.verifyPassword(passwordController.text);
                  },
                  text: "Войти",
                ),
                Expanded(flex: 10, child: SizedBox()),
                Center(
                  child: Text(
                    "Мы верим в твои силы!",
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
