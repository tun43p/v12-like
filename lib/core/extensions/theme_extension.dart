import 'package:flutter/material.dart';
import 'package:v12_like/core/theme/dark_theme.dart';

/// A utility extension for the [BuildContext].
extension BuildContextExtension on BuildContext {
  /// Returns the theme from the [BuildContext].
  ThemeData get theme => Theme.of(this);
}

/// A utility extension for themes.
extension ThemeExtension on ThemeData {
  /// Returns the dark text theme.
  TextTheme get fonts => darkTextTheme;
}
