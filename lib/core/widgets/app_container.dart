// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ruminate/core/styles/app_border_radiuses_extention.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onClick,
    this.height,
    this.backgroundColor,
    this.accentColor,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onClick;
  final double? height;
  final Color? backgroundColor;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final card = Container(
      constraints: BoxConstraints(minHeight: height ?? 140),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: theme.mediumBorderRadius,
        color: backgroundColor ?? colorScheme.surface,
        border: Border.all(
          color: (accentColor ?? colorScheme.onSurface).withOpacity(0.08),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            offset: const Offset(0, 10),
            color: Colors.black.withOpacity(0.04),
          ),
        ],
      ),
      child: Padding(
        padding: theme.largePadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (leading != null) ...[
              leading!,
              SizedBox(width: theme.mediumPaddingDouble),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: theme.smallPaddingDouble),
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.62),
                        height: 1.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 8), trailing!],
          ],
        ),
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: theme.mediumBorderRadius,
        onTap: onClick,
        child: card,
      ),
    );
  }
}
