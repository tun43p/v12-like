import 'package:flutter/material.dart';
import 'package:v12_like/core/extensions/color_extension.dart';

const String _fontFamily = 'AnonymousPro';

/// The dark theme for the application.
final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    backgroundColor: Colors.black,
    primarySwatch: const Color(0xFF00FF00).toMaterialColor,
    accentColor: const Color(0xFF00FF00),
    brightness: Brightness.dark,
    errorColor: const Color(0xFFFF0000),
    cardColor: const Color(0xFF202020),
  ),
  fontFamily: _fontFamily,
  textTheme: darkTextTheme,
);

/// The dark text theme for the application.
const TextTheme darkTextTheme = TextTheme(
  titleLarge: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  titleMedium: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  titleSmall: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  displayLarge: TextStyle(
    fontSize: 64,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  displayMedium: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  displaySmall: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  bodyLarge: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  bodyMedium: TextStyle(
    fontSize: 16,
    color: Colors.white,
  ),
  bodySmall: TextStyle(
    fontSize: 14,
    fontStyle: FontStyle.italic,
    color: Colors.white,
  ),
);
