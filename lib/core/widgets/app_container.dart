import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/providers/theme_provider.dart';
import 'package:ruminate/core/styles/app_border_radiuses_extention.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return GestureDetector(
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: Theme.of(context).mediumBorderRadius,
            ),
            child: Padding(
              padding: Theme.of(context).largePadding,
              child: Text("Test Text", style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer)),
            ),
          ),
          onTap: () => ref.read(themeIndexProvider.notifier).toogle(),
        );
      },
    );
  }
}
