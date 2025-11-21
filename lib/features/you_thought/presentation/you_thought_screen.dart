import 'package:flutter/material.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';
import 'package:ruminate/core/widgets/app_container.dart';

class YouThoughtScreen extends StatelessWidget {
  const YouThoughtScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: createAppBar(context),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: Text(
              "Ты думал об этом | дата",
              style: theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.primary),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: theme.extraLargePaddingDouble)),
          SliverToBoxAdapter(child: AppContainer(title: "ТУТ Будет заметка и прочее")),
        ],
      ),
    );
  }
}
