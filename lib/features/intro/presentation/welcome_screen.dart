import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/features/start/presentation/view_model/start_view_model.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startProvider = ref.watch(startViewModelProvider.notifier);
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.extraLargePaddingDouble,
          vertical: theme.extraLargePaddingDouble * 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Добро\nПожаловать!",
              style: theme.textTheme.headlineLarge!.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            Expanded(flex: 2, child: SizedBox()),
            Expanded(
              flex: 3,
              child: Text(
                '''Ruminate - ваш личный
помощник, позволяющий
докопаться до самых
неизведанных глубин
вашего сознания''',
                textAlign: TextAlign.start,
                style: theme.textTheme.headlineMedium!.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            AppButton(
              onClick: () {
                context.go("/onBoarding/before_start/");
                startProvider.setFirstEnter(false);
              },
              text: "Изменить свою жизнь",
            ),
          ],
        ),
      ),
    );
  }
}
