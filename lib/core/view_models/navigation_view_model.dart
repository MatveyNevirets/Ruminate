import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/providers/navigation_providers.dart';

class NavigationViewModel extends StateNotifier<int> {
  NavigationViewModel(this.ref) : super(0);
  final Ref ref;

  late final controller = ref.watch(pageControllerProvider);

  void goTo(int index) async {
    state = index;
    await controller.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}
