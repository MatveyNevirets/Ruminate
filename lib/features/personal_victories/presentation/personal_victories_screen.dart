import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_container.dart';
import 'package:ruminate/features/personal_victories/presentation/viewmodel/personal_victories_view_model.dart';

class PersonalVictoriesScreen extends ConsumerWidget {
  const PersonalVictoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final victoriesVM = ref.watch(personalVictoriesVMProvider);

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
              width: 320,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(56),
                color: colorScheme.primary.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            top: 260,
            left: -120,
            child: Container(
              width: 260,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(42),
                color: colorScheme.primary.withOpacity(0.045),
              ),
            ),
          ),
          Positioned(
            bottom: -170,
            right: -100,
            child: Container(
              width: 360,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(64),
                color: colorScheme.primary.withOpacity(0.05),
              ),
            ),
          ),
          SafeArea(
            child: victoriesVM.when(
              data: (victories) {
                if (victories != null && victories.isNotEmpty) {
                  return CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding: theme.largePadding.copyWith(top: 8),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _HeroCard(
                                title: "Личные победы",
                                subtitle:
                                    "Собирай подтверждения своего роста и возвращайся к моментам, которыми можно гордиться.",
                                icon: Icons.workspace_premium_rounded,
                              ),
                              SizedBox(height: theme.largePaddingDouble),
                              _SectionTitle(
                                title: "Твои достижения",
                                subtitle:
                                    "Даже маленькие победы со временем превращаются в большой путь.",
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: theme.largePadding.copyWith(top: 18),
                        sliver: SliverList.builder(
                          itemCount: victories.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: theme.mediumPaddingDouble,
                              ),
                              child: AppContainer(
                                title: victories[index],
                                accentColor: colorScheme.primary,
                                backgroundColor: colorScheme.surface,
                                leading: Container(
                                  height: 52,
                                  width: 52,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: colorScheme.primary.withOpacity(
                                      0.10,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.auto_awesome_rounded,
                                    color: colorScheme.primary,
                                    size: 26,
                                  ),
                                ),
                                trailing: Container(
                                  height: 36,
                                  width: 36,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: colorScheme.primary.withOpacity(
                                      0.08,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.check_rounded,
                                    color: colorScheme.primary,
                                    size: 20,
                                  ),
                                ),
                                onClick: () => (),
                              ),
                            );
                          },
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.only(
                          bottom: theme.largePaddingDouble * 2,
                        ),
                      ),
                    ],
                  );
                }

                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: theme.largePadding.copyWith(top: 8),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _HeroCard(
                              title: "Личные победы",
                              subtitle:
                                  "Здесь будут собираться важные моменты твоего роста и внутренние достижения.",
                              icon: Icons.workspace_premium_rounded,
                            ),
                            SizedBox(height: theme.largePaddingDouble),
                            _EmptyStateCard(
                              title: "Тут пока пусто",
                              subtitle:
                                  "Как только появятся личные победы — они будут отображаться здесь.",
                              icon: Icons.auto_awesome_outlined,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              loading: () => Center(
                child: _LoadingCard(
                  title: "Загружаю победы",
                  subtitle:
                      "Собираю все важные моменты и достижения в одном месте.",
                ),
              ),
              error: (e, stack) {
                log(
                  "Exception at the PersonalVictoriesViewModel in method fetchVictories(): $e StackTrace: $stack",
                );

                return Center(
                  child: Padding(
                    padding: theme.largePadding,
                    child: _StatusCard(
                      icon: Icons.error_outline_rounded,
                      title: "Что-то пошло не так :(",
                      subtitle:
                          "Не удалось загрузить личные победы. Попробуй открыть экран ещё раз.",
                      accent: colorScheme.error,
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
          crossAxisAlignment: CrossAxisAlignment.start,
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

class _LoadingCard extends StatelessWidget {
  const _LoadingCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: theme.largePadding,
      child: _SurfaceCard(
        accent: colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: colorScheme.primary.withOpacity(0.10),
                ),
                child: const Center(child: CircularProgressIndicator()),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.64),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyStateCard extends StatelessWidget {
  const _EmptyStateCard({
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
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: colorScheme.primary.withOpacity(0.10),
              ),
              child: Icon(icon, color: colorScheme.primary, size: 28),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.64),
                      height: 1.5,
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

class _StatusCard extends StatelessWidget {
  const _StatusCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return _SurfaceCard(
      accent: accent,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Icon(icon, color: accent, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.65),
                      height: 1.45,
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

class _SurfaceCard extends StatelessWidget {
  const _SurfaceCard({required this.child, this.accent});

  final Widget child;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: child,
        ),
      ),
    );
  }
}
