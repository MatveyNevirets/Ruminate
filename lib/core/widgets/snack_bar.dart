import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String text, {
  Duration duration = Durations.long3,
}) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colorScheme.primary.withOpacity(0.20)),
        borderRadius: BorderRadius.circular(18),
      ),
      elevation: 0,
      duration: duration,
      backgroundColor: colorScheme.surface,
      content: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
