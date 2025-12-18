import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  TextEditingController? controller;
  final double? height, width;
  AppTextField({super.key, this.controller, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 60,
      width: width ?? double.maxFinite,
      child: TextField(
        controller: controller,
        minLines: 1,
        maxLines: null,

        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary.withAlpha(150),
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
        ),
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
