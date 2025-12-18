import 'package:flutter/material.dart';

AppBar createAppBar(BuildContext context) {
  final theme = Theme.of(context);

  return AppBar(
    foregroundColor: theme.colorScheme.primary,
    surfaceTintColor: Colors.transparent,
    title: null,
    backgroundColor: theme.scaffoldBackgroundColor,
  );
}
