import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ruminate/core/widgets/app_button.dart';
import 'package:ruminate/features/start/presentation/view_model/start_view_model.dart';
import 'package:ruminate/features/start/providers/start_repository_provider.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startProvider = ref.watch(startViewModelProvider);

    return Scaffold(body: Center(child: Text("Hey@!")));
  }
}
