import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ruminate/application/app_runner/app_env.dart';
import 'package:ruminate/application/application.dart';
import 'package:ruminate/application/provider/app_env_provider.dart';
import 'package:ruminate/firebase_options.dart';

class AppRunner {
  final AppEnv env;
  AppRunner(this.env);

  Future<void> run() async {
    runZonedGuarded(
      () async {
        await _init();

        try {
          await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          );
        } on Object catch (e, stack) {
          throw Exception("$e StackTrace: $stack");
        }

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

  Future<void> _init() async {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.deferFirstFrame();
  }
}
