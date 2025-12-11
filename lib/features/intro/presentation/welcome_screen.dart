import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/core/widgets/app_button.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen(this.startData, {super.key});
  List<bool> startData;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late final isFirstEnter = widget.startData[0];
  late final isHavePassword = widget.startData[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Welcome"),
          AppButton(onClick: () => (), text: "дальше"),
        ],
      ),
    );
  }
}
