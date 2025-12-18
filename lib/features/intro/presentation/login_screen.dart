import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/core/widgets/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
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
                  "Войдите в\nАккаунт",
                  textAlign: TextAlign.start,
                  style: theme.textTheme.headlineLarge!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: theme.largePaddingDouble),
                Text(
                  '''Если вы собираетесь устанавливать пароль, вам пригодиться аккаунт''',
                  style: theme.textTheme.headlineSmall!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: theme.largePaddingDouble),
                Text(
                  '''Почта''',
                  style: theme.textTheme.headlineSmall!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                AppTextField(),
                SizedBox(height: theme.mediumPaddingDouble),
                Text(
                  '''Пароль''',
                  style: theme.textTheme.headlineSmall!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                AppTextField(),
                Expanded(child: SizedBox()),

                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 40, width: 40, child: Placeholder()),
                      SizedBox(height: theme.mediumPaddingDouble),
                      Text(
                        textAlign: TextAlign.center,
                        '''Продолжить с Google''',
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: SizedBox()),
                AppButton(
                  onClick: () {
                    context.go("/onBoarding/before_start/login/password_set/");
                  },
                  text: "Войти",
                ),
                SizedBox(height: theme.largePaddingDouble),
                AppButton(
                  onClick: () {
                    context.go("/onBoarding/before_start/login/registration/");
                  },
                  text: "Продолжить без аккаунта",
                ),
                SizedBox(height: theme.largePaddingDouble),
                Center(
                  child: GestureDetector(
                    onTap: () => context.go(
                      "/onBoarding/before_start/login/registration/",
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Еще нет аккаунта? ",
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          TextSpan(
                            text: "Зарегистрироваться",
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: theme.colorScheme.tertiary,
                            ),
                          ),
                        ],
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
  }
}
