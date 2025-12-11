import 'package:flutter/material.dart';
import 'package:ruminate/core/widgets/app_button.dart';

class BeforeStartScreen extends StatelessWidget {
  const BeforeStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppButton(onClick: () => (), text: "дальше"),
      ),
    );
  }
}
