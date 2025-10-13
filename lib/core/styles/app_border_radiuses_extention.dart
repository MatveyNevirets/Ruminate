import 'package:flutter/material.dart';

extension ThemeBorderRadiuses on ThemeData {
  BorderRadius get smallBorderRadius => BorderRadius.circular(4);
  BorderRadius get mediumBorderRadius => BorderRadius.circular(8);
  BorderRadius get largeBorderRadius => BorderRadius.circular(16);
}
