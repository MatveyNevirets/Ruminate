import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  AppButton({super.key, this.buttonSize, required this.onClick, required this.text});

  Size? buttonSize;
  final VoidCallback onClick;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonSize?.width ?? double.maxFinite,
      height: buttonSize?.height ?? 60,
      child: ElevatedButton(
        onPressed: () => onClick.call(),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
