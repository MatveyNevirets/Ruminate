import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_button.dart';

class StartDailyReflectionScreen extends ConsumerWidget {
  const StartDailyReflectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: -120,
            right: -90,
            child: Container(
              width: 300,
              height: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(56),
                color: colorScheme.primary.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            top: 240,
            left: -120,
            child: Container(
              width: 260,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: colorScheme.primary.withOpacity(0.045),
              ),
            ),
          ),
          Positioned(
            bottom: -170,
            right: -90,
            child: Container(
              width: 340,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: colorScheme.primary.withOpacity(0.05),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: theme.largePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HeroCard(
                      title: "Как рефлексируем сегодня?",
                      subtitle:
                          "Выбери глубину — от быстрого обзора до подробного разбора дня.",
                      icon: Icons.auto_awesome_rounded,
                    ),
                    SizedBox(height: theme.largePaddingDouble),

                    _SectionTitle(
                      title: "Поверхностно",
                      subtitle:
                          "Подходит, когда хочется быстро зафиксировать состояние без лишней нагрузки.",
                    ),
                    SizedBox(height: theme.mediumPaddingDouble),
                    _ModeCard(
                      title: "Поверхностный обзор",
                      subtitle:
                          "10 вопросов для короткой и мягкой рефлексии, когда нет сил на длинный формат.",
                      details: const [
                        "10 вопросов",
                        "Быстрый формат",
                        "Легко начать даже в конце дня",
                      ],
                      icon: Icons.bolt_rounded,
                      accent: colorScheme.tertiary,
                      onTap: () => context.go(
                        "/home/daily_reflection/superficial_reflection",
                      ),
                      buttonText: "Начать поверхностную рефлексию",
                    ),
                    SizedBox(height: theme.largePaddingDouble * 1.15),
                    _SectionTitle(
                      title: "Глубоко",
                      subtitle:
                          "Подходит, когда хочется спокойно разобрать день по слоям.",
                    ),
                    SizedBox(height: theme.mediumPaddingDouble),
                    _ModeCard(
                      title: "Глубокое погружение",
                      subtitle:
                          "30 вопросов помогут тщательно исследовать мысли, эмоции и события дня.",
                      details: const [
                        "30 вопросов",
                        "Для вдумчивой работы",
                        "Подходит для вечернего ритуала",
                      ],
                      icon: Icons.water_drop_rounded,
                      accent: colorScheme.primary,
                      onTap: () => context.go(
                        "/home/daily_reflection/indepth_reflection/",
                      ),
                      buttonText: "Начать глубокую рефлексию",
                    ),

                    SizedBox(height: theme.largePaddingDouble * 1.5),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _SurfaceCard(
      accent: colorScheme.primary,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary.withOpacity(0.11),
              colorScheme.surfaceContainerHighest.withOpacity(0.16),
            ],
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: colorScheme.primary.withOpacity(0.14),
                border: Border.all(
                  color: colorScheme.primary.withOpacity(0.10),
                ),
              ),
              child: Icon(icon, size: 36, color: colorScheme.primary),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.8,
                      height: 1.05,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.64),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withOpacity(0.60),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _ModeCard extends StatelessWidget {
  const _ModeCard({
    required this.title,
    required this.subtitle,
    required this.details,
    required this.icon,
    required this.accent,
    required this.onTap,
    required this.buttonText,
  });

  final String title;
  final String subtitle;
  final List<String> details;
  final IconData icon;
  final Color accent;
  final VoidCallback onTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _SurfaceCard(
      accent: accent,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: colorScheme.surfaceContainerHighest.withOpacity(0.12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 58,
                  width: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: accent.withOpacity(0.12),
                    border: Border.all(color: accent.withOpacity(0.10)),
                  ),
                  child: Icon(icon, color: accent, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.66),
                          height: 1.55,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: details
                  .map((item) => _MiniChip(text: item, color: accent))
                  .toList(),
            ),
            const SizedBox(height: 22),
            AppButton(
              onClick: onTap,
              text: buttonText,
              icon: Icons.arrow_forward_rounded,
              backgroundColor: accent,
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniChip extends StatelessWidget {
  const _MiniChip({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.10)),
      ),
      child: Text(
        text,
        style: theme.textTheme.labelMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SurfaceCard extends StatelessWidget {
  const _SurfaceCard({required this.child, this.accent});

  final Widget child;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final borderColor = (accent ?? colorScheme.onSurface).withOpacity(0.08);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: colorScheme.surface,
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            blurRadius: 26,
            offset: const Offset(0, 12),
            color: Colors.black.withOpacity(0.045),
          ),
        ],
      ),
      child: child,
    );
  }
}
