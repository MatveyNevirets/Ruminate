import 'package:flutter/material.dart';
import 'package:ruminate/core/widgets/app_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Login"),
            AppButton(onClick: () => (), text: "дальше"),
          ],
        ),
      ),
    );
  }
}
