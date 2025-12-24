import 'package:flutter/material.dart';

class AppDualStateButton extends StatelessWidget {
  AppDualStateButton({
    super.key,
    this.buttonSize,
    this.backgroundColor,
    this.isSelected = false,
    this.radius = 64,
    this.onNotSelectedClick,
    required this.onClick,
    required this.text,
    required this.selectedText,
  });

  Size? buttonSize;
  double radius;
  final VoidCallback? onClick, onNotSelectedClick;
  bool isSelected;
  Color? backgroundColor;
  final String text, selectedText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonSize?.width ?? double.maxFinite,
      height: buttonSize?.height ?? 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          backgroundColor: isSelected
              ? Theme.of(context).colorScheme.surfaceContainer.withAlpha(180)
              : Theme.of(context).colorScheme.surfaceContainer,
        ),
        onPressed: () {
          if (isSelected && onNotSelectedClick != null) {
            onClick!.call();
          } else if (onNotSelectedClick == null) {
            onClick!.call();
          } else {
            onNotSelectedClick?.call();
          }
        },
        child: Text(
          isSelected ? selectedText : text,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: isSelected
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
