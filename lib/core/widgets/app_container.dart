// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/providers/theme_provider.dart';
import 'package:ruminate/core/styles/app_border_radiuses_extention.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';

class AppContainer extends StatelessWidget {
  AppContainer({super.key, this.title, this.onClick});
  String? title;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return GestureDetector(
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(borderRadius: Theme.of(context).mediumBorderRadius),
            child: Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: Theme.of(context).largePadding,
                child: Text(
                  title ?? "",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              ),
            ),
          ),
          onTap: () => onClick == null ? ref.read(themeIndexProvider.notifier).toggle() : onClick!.call(),
        );
      },
    );
  }
}
