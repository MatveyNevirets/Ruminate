import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ruminate/core/view_models/navigation_view_model.dart';

final pageControllerProvider = Provider<PageController>((ref) => PageController(initialPage: 0));
final navigationViewModel = StateNotifierProvider<NavigationViewModel, int>((ref) => NavigationViewModel(ref));
