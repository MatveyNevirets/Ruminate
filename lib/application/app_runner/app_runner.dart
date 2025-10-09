import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/application/app_runner/app_env.dart';
import 'package:ruminate/application/application.dart';

class AppRunner {
  final AppEnv env;
  AppRunner(this.env);

  Future<void> run() async {
    runZonedGuarded(
      () async {
        await _init();

        final appEnvProvider = Provider<AppEnv>((ref) => env);

        runApp(ProviderScope(overrides: [appEnvProvider], child: Application()));

        WidgetsBinding.instance.addPostFrameCallback((_) {
          WidgetsBinding.instance.allowFirstFrame();
        });
      },
      (e, stack) {
        throw Exception("Exception: $e StackTrace: $stack");
      },
    );
  }

  Future<void> _init() async {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.deferFirstFrame();
  }
}
