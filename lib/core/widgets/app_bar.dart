import 'package:flutter/material.dart';

AppBar createAppBar(BuildContext context) => AppBar(
  foregroundColor: Theme.of(context).colorScheme.onPrimary,
  title: Text(
    "Ruminate",
    style: TextStyle(fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onPrimary),
  ),
  backgroundColor: Theme.of(context).colorScheme.primary,
);
