import 'package:flutter/material.dart';

AppBar createAppBar(BuildContext context, {String? title}) {
  final theme = Theme.of(context);

  return AppBar(
    foregroundColor: theme.colorScheme.primary,
    surfaceTintColor: Colors.transparent,
    title: title == null
        ? null
        : Text(
            title,
            style: theme.textTheme.bodyLarge!.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
    backgroundColor: theme.scaffoldBackgroundColor,
  );
}
