import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/features/start/presentation/view_model/start_view_model.dart';

class BeforeStartScreen extends ConsumerWidget {
  const BeforeStartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: theme.extraLargePaddingDouble,
          vertical: theme.extraLargePaddingDouble,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Перед тем как\nНачать",
              textAlign: TextAlign.start,
              style: theme.textTheme.headlineLarge!.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            Expanded(child: SizedBox()),
            Text(
              '''
В Ruminate данные храняться исключительно на вашем устройсте, удаление приложения повлечет за собой удаление данных\n\nВы можете сохранять ваши рефлексии в отдельные файлы\nТакую возможность вы найдете в разделе "Профиль"
                ''',
              style: theme.textTheme.headlineSmall!.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            SizedBox(height: theme.largePaddingDouble),
            AppButton(
              onClick: () {
                context.go("/onBoarding/before_start/password_set/");
              },
              text: "Понятно",
            ),
          ],
        ),
      ),
    );
  }
}
