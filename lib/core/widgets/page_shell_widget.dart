import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_button.dart';

class PageShell extends StatelessWidget {
  const PageShell({
    super.key,
    required this.title,
    required this.subtitle,
    required this.primaryActionText,
    required this.onPrimaryAction,
    this.secondaryActionText,
    this.onSecondaryAction,
    this.icon,
    this.child,
  });

  final String title;
  final String subtitle;
  final String primaryActionText;
  final VoidCallback onPrimaryAction;
  final String? secondaryActionText;
  final VoidCallback? onSecondaryAction;
  final IconData? icon;
  final Widget? child;

  double _titleSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 360) return 32;
    if (width < 400) return 36;
    if (width < 460) return 39;
    return 42;
  }

  double _subtitleSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 360) return 14.5;
    if (width < 400) return 15;
    return 16;
  }

  double _iconSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 360) return 72;
    return 84;
  }

  double _iconInnerSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 360) return 32;
    return 38;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final horizontalPadding = MediaQuery.sizeOf(context).width < 360
        ? theme.largePaddingDouble
        : theme.extraLargePaddingDouble;

    final topSpacing = MediaQuery.sizeOf(context).width < 360
        ? theme.smallPaddingDouble
        : theme.mediumPaddingDouble;

    final titleSize = _titleSize(context);
    final subtitleSize = _subtitleSize(context);
    final iconSize = _iconSize(context);
    final iconInnerSize = _iconInnerSize(context);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned(
            top: -120,
            right: -80,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primary.withOpacity(0.12),
              ),
            ),
          ),
          Positioned(
            bottom: -180,
            left: -120,
            child: Container(
              width: 340,
              height: 340,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primary.withOpacity(0.07),
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: context.canPop()
                        ? MediaQuery.sizeOf(context).height / 20
                        : MediaQuery.sizeOf(context).height / 8,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          SizedBox(height: topSpacing),

                          if (context.canPop()) ...[
                            const _BackButton(),
                            SizedBox(
                              height: MediaQuery.sizeOf(context).width < 360
                                  ? 28
                                  : 36,
                            ),
                          ] else ...[
                            SizedBox(
                              height: MediaQuery.sizeOf(context).width < 360
                                  ? 12
                                  : 18,
                            ),
                          ],

                          if (icon != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 12,
                                  sigmaY: 12,
                                ),
                                child: Container(
                                  width: iconSize,
                                  height: iconSize,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(28),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        colorScheme.primary.withOpacity(0.22),
                                        colorScheme.primary.withOpacity(0.06),
                                      ],
                                    ),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.08),
                                    ),
                                  ),
                                  child: Icon(
                                    icon,
                                    size: iconInnerSize,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ),
                            ),

                          SizedBox(
                            height: MediaQuery.sizeOf(context).width < 360
                                ? 28
                                : 34,
                          ),

                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 520),
                            child: Text(
                              title,
                              style: theme.textTheme.headlineLarge?.copyWith(
                                fontSize: titleSize,
                                height: 1.0,
                                letterSpacing: -1.6,
                                fontWeight: FontWeight.w900,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),

                          SizedBox(
                            height: MediaQuery.sizeOf(context).width < 360
                                ? 14
                                : 18,
                          ),

                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 540),
                            child: Text(
                              subtitle,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                height: 1.65,
                                fontSize: subtitleSize,
                                letterSpacing: -0.1,
                                fontWeight: FontWeight.w500,
                                color: colorScheme.onSurface.withOpacity(0.62),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: MediaQuery.sizeOf(context).width < 360
                                ? 40
                                : 48,
                          ),

                          child != null
                              ? Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(22),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    color: colorScheme.surface.withOpacity(
                                      0.55,
                                    ),
                                    border: Border.all(
                                      color: colorScheme.outline.withOpacity(
                                        0.08,
                                      ),
                                    ),
                                  ),
                                  child: child,
                                )
                              : SizedBox(),

                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.sizeOf(context).width < 360
                                  ? 24
                                  : 30,
                              bottom:
                                  MediaQuery.of(context).padding.bottom + 18,
                            ),
                            child: Column(
                              children: [
                                AppButton(
                                  onClick: onPrimaryAction,
                                  text: primaryActionText,
                                  icon: Icons.arrow_forward_rounded,
                                ),
                                if (secondaryActionText != null) ...[
                                  const SizedBox(height: 14),
                                  Center(
                                    child: TextButton(
                                      onPressed: onSecondaryAction,
                                      style: TextButton.styleFrom(
                                        foregroundColor: colorScheme.onSurface
                                            .withOpacity(0.55),
                                      ),
                                      child: Text(
                                        secondaryActionText!,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => context.pop(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: colorScheme.surface.withOpacity(0.55),
              border: Border.all(color: colorScheme.outline.withOpacity(0.08)),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
