import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ruminate/features/auth/presentation/auth_screen.dart';
import 'package:ruminate/features/intro/presentation/welcome_screen.dart';
import 'package:ruminate/features/start/presentation/view_model/start_view_model.dart';

class StartScreen extends ConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(body: Center(child: Text("data")));
  }
}
