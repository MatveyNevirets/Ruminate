import 'package:flutter/material.dart';
import 'package:ruminate/core/styles/app_paddings_extention.dart';
import 'package:ruminate/core/widgets/app_bar.dart';

class DailyReflectionScreen extends StatelessWidget {
  const DailyReflectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(context),
      body: ListView(
        children: [
          Padding(
            padding: Theme.of(context).largePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ежедневная рефлексия",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                SizedBox(height: Theme.of(context).largePaddingDouble),
                Text(
                  "Как прошел день? Коротко",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                TextField(decoration: InputDecoration()),
                SizedBox(height: Theme.of(context).mediumPaddingDouble),
                Text(
                  "Что ты сделал хорошо?",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                TextField(decoration: InputDecoration()),
                SizedBox(height: Theme.of(context).largePaddingDouble),
                Text(
                  "Укажи ниже 3 главные победы дня. Даже не значительные",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                SizedBox(height: Theme.of(context).mediumPaddingDouble),
                Text(
                  "Победа номер 1",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                TextField(decoration: InputDecoration()),
                SizedBox(height: Theme.of(context).mediumPaddingDouble),
                Text(
                  "Победа номер 2",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                TextField(decoration: InputDecoration()),
                SizedBox(height: Theme.of(context).mediumPaddingDouble),
                Text(
                  "Победа номер 3",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                TextField(decoration: InputDecoration()),
                SizedBox(height: Theme.of(context).largePaddingDouble),
                Text(
                  "Вопросы к развитию и анализу",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                SizedBox(height: Theme.of(context).mediumPaddingDouble),
                Text(
                  "Что можно было улучшить?",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                TextField(decoration: InputDecoration()),
                SizedBox(height: Theme.of(context).mediumPaddingDouble),
                Text(
                  "От чего ты бы мог отказаться и это бы сильно помогло тебе?",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
                TextField(decoration: InputDecoration()),
                SizedBox(height: Theme.of(context).largePaddingDouble),
                SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: ElevatedButton(onPressed: () {}, child: Text("Готово")),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
