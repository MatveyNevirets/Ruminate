import 'package:flutter/material.dart';

class AppDualStateButton extends StatelessWidget {
  const AppDualStateButton({
    super.key,
    this.buttonSize,
    this.backgroundColor,
    this.isSelected = false,
    this.radius = 20,
    this.onNotSelectedClick,
    required this.onClick,
    required this.text,
    required this.selectedText,
  });

  final Size? buttonSize;
  final double radius;
  final VoidCallback onClick;
  final VoidCallback? onNotSelectedClick;
  final bool isSelected;
  final Color? backgroundColor;
  final String text;
  final String selectedText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: buttonSize?.width ?? double.maxFinite,
      height: buttonSize?.height ?? 56,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: isSelected
              ? (backgroundColor ?? colorScheme.primary).withOpacity(0.12)
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary.withOpacity(0.22)
                : colorScheme.onSurface.withOpacity(0.08),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(radius),
            onTap: () {
              if (isSelected && onNotSelectedClick != null) {
                onNotSelectedClick!.call();
                return;
              }
              onClick.call();
            },
            child: Center(
              child: Text(
                isSelected ? selectedText : text,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
