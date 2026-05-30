import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_container.dart';

class StringListScreen extends StatelessWidget {
  const StringListScreen({
    super.key,
    required this.strings,
    required this.title,
  });

  final List<String?>? strings;
  final String title;

  double _titleSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 360) return 28;
    if (width < 400) return 31;
    return 34;
  }

  double _subtitleSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 360) return 14.5;
    if (width < 400) return 15;
    return 16;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final filteredStrings =
        strings
            ?.where((e) => e != null && e.trim().isNotEmpty)
            .cast<String>()
            .toList() ??
        [];

    final isCompact = MediaQuery.sizeOf(context).width < 360;
    final horizontalPadding = isCompact
        ? theme.largePaddingDouble
        : theme.extraLargePaddingDouble;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: -120,
            right: -90,
            child: Container(
              width: 320,
              height: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(54),
                color: colorScheme.primary.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            top: 260,
            left: -120,
            child: Container(
              width: 260,
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: colorScheme.primary.withOpacity(0.04),
              ),
            ),
          ),
          Positioned(
            bottom: -160,
            right: -100,
            child: Container(
              width: 360,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: colorScheme.primary.withOpacity(0.05),
              ),
            ),
          ),
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: theme.mediumPaddingDouble),
                        if (context.canPop()) ...[
                          const _BackButton(),
                          SizedBox(height: isCompact ? 28 : 36),
                        ] else ...[
                          SizedBox(height: isCompact ? 12 : 18),
                        ],
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 540),
                          child: Text(
                            title,
                            style: theme.textTheme.headlineLarge?.copyWith(
                              fontSize: _titleSize(context),
                              height: 1.0,
                              letterSpacing: -1.3,
                              fontWeight: FontWeight.w900,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                        SizedBox(height: isCompact ? 14 : 18),
                        Text(
                          filteredStrings.isEmpty
                              ? ""
                              : "Список сохранённых записей и заметок, к которым можно вернуться позже.",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            height: 1.65,
                            fontSize: _subtitleSize(context),
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onSurface.withOpacity(0.62),
                          ),
                        ),
                        SizedBox(height: isCompact ? 36 : 42),
                      ],
                    ),
                  ),
                ),
                if (filteredStrings.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: theme.largePaddingDouble,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height / 3,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: colorScheme.surface.withOpacity(0.72),
                          border: Border.all(
                            color: colorScheme.outline.withOpacity(0.08),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 68,
                              height: 68,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                color: colorScheme.primary.withOpacity(0.10),
                              ),
                              child: Icon(
                                Icons.inbox_rounded,
                                size: 32,
                                color: colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 18),
                            Text(
                              "Тут пока ничего нет",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Когда здесь появятся записи — ты сможешь быстро к ним возвращаться.",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                height: 1.55,
                                color: colorScheme.onSurface.withOpacity(0.62),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      0,
                      horizontalPadding,
                      theme.largePaddingDouble * 2,
                    ),
                    sliver: SliverList.separated(
                      itemCount: filteredStrings.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(height: theme.mediumPaddingDouble),
                      itemBuilder: (context, index) {
                        final value = filteredStrings[index];

                        return AppContainer(
                          title: value,
                          subtitle: "Сохранённая запись",
                          onClick: () {},
                          leading: Container(
                            width: 54,
                            height: 54,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: colorScheme.primary.withOpacity(0.10),
                            ),
                            child: Icon(
                              Icons.auto_stories_rounded,
                              color: colorScheme.primary,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: colorScheme.onSurface.withOpacity(0.38),
                          ),
                        );
                      },
                    ),
                  ),
              ],
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
