import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/core/widgets/app_text_field.dart';

class PasswordSetScreen extends StatelessWidget {
  const PasswordSetScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                AppTextField(),
                SizedBox(height: theme.mediumPaddingDouble),
                Text(
                  '''Повторите пароль''',
                  style: theme.textTheme.headlineSmall!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                AppTextField(),

                Expanded(flex: 2, child: SizedBox()),
                AppButton(
                  onClick: () {
                    context.go(
                      "/onBoarding/before_start/password_set/where_change/",
                    );
                  },
                  text: "Установить пароль",
                ),
                SizedBox(height: theme.largePaddingDouble),
                AppButton(
                  onClick: () {
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
