import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_container.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("Ruminate", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: Theme.of(context).largePadding,
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(child: AppContainer()),
                SizedBox(width: Theme.of(context).mediumPaddingDouble),
                Expanded(child: AppContainer()),
              ],
            ),
            SizedBox(height: Theme.of(context).mediumPaddingDouble),
            AppContainer(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_work_outlined, color: Theme.of(context).colorScheme.onPrimary),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outline, color: Theme.of(context).colorScheme.onPrimary),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box_outlined, color: Theme.of(context).colorScheme.onPrimary),
            label: "",
          ),
        ],
      ),
    );
  }
}
