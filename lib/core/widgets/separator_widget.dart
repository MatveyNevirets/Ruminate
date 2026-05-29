import 'package:flutter/material.dart';

class SeparatorWidget extends StatelessWidget {
  const SeparatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.onSurface.withOpacity(0.02),
            theme.colorScheme.onSurface.withOpacity(0.12),
            theme.colorScheme.onSurface.withOpacity(0.02),
          ],
        ),
      ),
    );
  }
}
