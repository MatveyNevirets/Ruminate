import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final pageControllerProvider = Provider<PageController>((ref) => PageController(initialPage: 0));
final navigationNotifierProvider = StateNotifierProvider<NavigationNotifier, int>((ref) => NavigationNotifier(ref));

class NavigationNotifier extends StateNotifier<int> {
  NavigationNotifier(this.ref) : super(0);
  final Ref ref;

  late final controller = ref.watch(pageControllerProvider);

  void goTo(int index) async {
    state = index;
    await controller.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}
