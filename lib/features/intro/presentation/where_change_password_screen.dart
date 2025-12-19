import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_button.dart';

class WhereChangePasswordScreen extends StatelessWidget {
  const WhereChangePasswordScreen({super.key});

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
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Кто-то узнал\nПароль?",
                  textAlign: TextAlign.start,
                  style: theme.textTheme.headlineLarge!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                Expanded(child: SizedBox()),
                Text(
                  '''Ты всегда можешь его изменить, удалить или добавить в разделе "Профиль"''',
                  style: theme.textTheme.headlineSmall!.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                SizedBox(height: theme.largePaddingDouble),

                Expanded(flex: 8, child: SizedBox()),
                AppButton(
                  onClick: () {
                    context.go(
                      "/onBoarding/before_start/password_set/where_change/go_home",
                    );
                  },
                  text: "Изменить свою жизнь",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
