import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.buttonSize,
    this.backgroundColor,
    required this.onClick,
    required this.text,
    this.icon,
    this.isExpanded = true,
  });

  final Size? buttonSize;
  final VoidCallback onClick;
  final Color? backgroundColor;
  final String text;
  final IconData? icon;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final button = SizedBox(
      width: buttonSize?.width ?? (isExpanded ? double.infinity : null),
      height: buttonSize?.height ?? 58,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18),
        ),
        onPressed: onClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18),
              const SizedBox(width: 10),
            ],
            Text(
              text,
              style: theme.textTheme.labelLarge?.copyWith(
                color: colorScheme.onPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );

    return button;
  }
}
