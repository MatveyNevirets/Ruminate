import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/application/app_runner/app_env.dart';
import 'package:ruminate/application/application.dart';
import 'package:ruminate/application/provider/app_env_provider.dart';

class AppRunner {
  final AppEnv env;
  AppRunner(this.env);

  Future<void> run() async {
    runZonedGuarded(
      () async {
        await _init();

        await _initDependecies();

        runApp(
          ProviderScope(
            overrides: [appEnvProvider.overrideWithValue(env)],
            child: Application(),
          ),
        );

        WidgetsBinding.instance.addPostFrameCallback((_) {
          WidgetsBinding.instance.allowFirstFrame();
        });
      },
      (e, stack) {
        throw Exception("Exception: $e StackTrace: $stack");
      },
    );
  }

  Future<void> _initDependecies() async {
    await dotenv.load(fileName: ".env");
  }

  Future<void> _init() async {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.deferFirstFrame();
  }
}
