import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:ruminate/core/auth/data/auth_params/login_params.dart';
import 'package:ruminate/core/auth/presentation/view_model/auth_view_model.dart';
import 'package:ruminate/core/auth/usecases/google_login_usecase.dart';

import 'package:ruminate/core/styles/app_paddings_extention.dart';

import 'package:ruminate/core/widgets/app_button.dart';

import 'package:ruminate/core/widgets/app_text_field.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final firebaseAuth = ref.watch(firebaseAuthViewModel.notifier);
    final emailController = TextEditingController(),
        passwordController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: theme.extraLargePaddingDouble,

            vertical: theme.extraLargePaddingDouble * 2,
          ),

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

              Text(
                '''Если вы собираетесь устанавливать пароль, вам пригодиться аккаунт''',

                style: theme.textTheme.headlineSmall!.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),

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

              SizedBox(height: theme.largePaddingDouble),

              GestureDetector(
                onTap: () => firebaseAuth.loginWithGoogle(GoogleLoginUsecase()),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 60, width: 60, child: Placeholder()),

                      SizedBox(height: theme.mediumPaddingDouble),

                      Text(
                        textAlign: TextAlign.center,

                        '''Войти с\nGoogle''',

                        style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: theme.largePaddingDouble),

              AppButton(
                onClick: () {
                  firebaseAuth.loginWithEmail(
                    FirebaseEmailCase(
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                  );
                },

                text: "Войти",
              ),

              SizedBox(height: theme.largePaddingDouble),

              AppButton(
                onClick: () {
                  context.go("/onBoarding/before_start/login/registration/");
                },

                text: "Регистрация",
              ),

              SizedBox(height: theme.largePaddingDouble),

              Text(
                textAlign: TextAlign.center,

                '''Если вам не нужен аккаунт, оставьте поля пустыми и нажмите "Войти"''',

                style: theme.textTheme.bodySmall!.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
