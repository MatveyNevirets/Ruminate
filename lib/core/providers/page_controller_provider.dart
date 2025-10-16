import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/legacy.dart';

class PageNotifier extends StateNotifier<int> {
  PageNotifier([super.initial = 0]);

  final pageController = PageController();

  void changePage(int index) {
    state = index;
    pageController.jumpTo(1);
    log(state.toString());
    log(pageController.page.toString());
  }
}

final pageProvider = StateNotifierProvider<PageNotifier, int>((ref) => PageNotifier());
