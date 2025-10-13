import 'package:flutter/material.dart';

extension ThemePaddings on ThemeData {
  EdgeInsets get smallPadding => EdgeInsets.all(4);
  EdgeInsets get mediumPadding => EdgeInsets.all(8);
  EdgeInsets get largePadding => EdgeInsets.all(16);
  EdgeInsets get extraLargePadding => EdgeInsets.all(32);

  double get smallPaddingDouble => 4;
  double get mediumPaddingDouble => 8;
  double get largePaddingDouble => 16;
  double get extraLargePaddingDouble => 32;
}
