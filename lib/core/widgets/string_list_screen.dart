import 'package:flutter/material.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_container.dart';

class StringListScreen extends StatelessWidget {
  const StringListScreen({
    super.key,
    required this.strings,
    required this.title,
  });

  final List<String?>? strings;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: createAppBar(context),
      body: strings == null
          ? Center(
              child: Text(
                "Тут пока ничего нет",
                style: theme.textTheme.headlineMedium!.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            )
          : CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: theme.largePadding.copyWith(
                    top: theme.largePadding.top * 2,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      title,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: theme.largePadding,
                  sliver: SliverList.builder(
                    itemCount: strings!.length,
                    itemBuilder: (context, index) {
                      return strings![index] == null || strings![index]!.isEmpty
                          ? Container()
                          : AppContainer(
                              title: strings![index],
                              onClick: () => (),
                            );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
