import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/core/widgets/app_text_field.dart';
import 'package:ruminate/features/intro/presentation/view_model/password_view_model.dart';
import 'package:ruminate/features/start/presentation/view_model/start_view_model.dart';

class PasswordSetScreen extends ConsumerWidget {
  PasswordSetScreen({super.key});

  final firstPasswordController = TextEditingController(),
      secondPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final startVM = ref.watch(startViewModelProvider.notifier);
    final passwordVM = ref.watch(passwordViewModelProvider.notifier);
    final passwordVMState = ref.watch(passwordViewModelProvider);
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
                  "Личное —\nНе публичное",
                  textAlign: TextAlign.start,
                  style: theme.textTheme.headlineLarge!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: theme.largePaddingDouble),
                Text(
                  '''Чтобы ваши рефлексии были доступны только вам, вы можете установить пароль''',
                  style: theme.textTheme.headlineSmall!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                Expanded(child: SizedBox()),
                Text(
                  '''Пароль''',
                  style: theme.textTheme.headlineSmall!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                AppTextField(controller: firstPasswordController),
                SizedBox(height: theme.mediumPaddingDouble),
                Text(
                  '''Повторите пароль''',
                  style: theme.textTheme.headlineSmall!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                AppTextField(controller: secondPasswordController),

                Expanded(flex: 2, child: SizedBox()),
                AppButton(
                  onClick: () {
                    startVM.setFirstEnter(false);
                    final firstPassword = firstPasswordController.text;
                    final secondPassword = secondPasswordController.text;

                    if (firstPassword == secondPassword) {
                      passwordVM.setPassword(firstPassword);
                      startVM.setHavePassword(true);

                      passwordVMState.when(
                        data: (data) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text("Success!")));
                          context.go(
                            "/onBoarding/before_start/password_set/where_change/",
                          );
                        },
                        error: (Object e, StackTrace stack) {
                          throw Exception("$e StackTrace: $stack");
                        },
                        loading: () {
                          return CircularProgressIndicator();
                        },
                      );
                    } else {
                      firstPasswordController.text = "";
                      secondPasswordController.text = "";
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("Error!")));
                    }
                  },
                  text: "Установить пароль",
                ),
                SizedBox(height: theme.largePaddingDouble),
                AppButton(
                  onClick: () {
                    startVM.setFirstEnter(false);
                    context.go(
                      "/onBoarding/before_start/password_set/where_change/",
                    );
                  },
                  text: "Продолжить без пароля",
                ),
                SizedBox(height: theme.largePaddingDouble),
                Center(
                  child: Text(
                    "Мы рекомендуем установить пароль!",
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
