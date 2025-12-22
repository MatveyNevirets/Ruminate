import 'package:flutter/material.dart';

class AppDualStateButton extends StatelessWidget {
  AppDualStateButton({
    super.key,
    this.buttonSize,
    this.backgroundColor,
    this.isSelected = false,
    required this.onClick,
    required this.text,
    required this.selectedText,
  });

  Size? buttonSize;
  final VoidCallback onClick;
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
          backgroundColor: isSelected
              ? backgroundColor?.withAlpha(150)
              : backgroundColor,
        ),
        onPressed: () => onClick.call(),
        child: Text(
          isSelected ? selectedText : text,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
