import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String text, {
  Duration duration = Durations.long2,
}) {
  final theme = Theme.of(context);
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: theme.colorScheme.primary, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 3,
      duration: duration,
      backgroundColor: theme.colorScheme.secondaryContainer,
      content: Text(
        text,
        style: theme.textTheme.bodyMedium!.copyWith(
          color: theme.colorScheme.onSecondaryContainer,
        ),
      ),
    ),
  );
}
