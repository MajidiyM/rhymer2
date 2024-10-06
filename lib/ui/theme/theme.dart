import 'package:flutter/material.dart';

const primaryColor = Color(0xFFF82B10);
final themeData = ThemeData();

final darkTheme = ThemeData(
  useMaterial3: true,
  textTheme: textTheme,
  scaffoldBackgroundColor: Colors.black,
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: primaryColor,
  ),
);

final lightTheme = ThemeData(
  useMaterial3: true,
  textTheme: textTheme,
  scaffoldBackgroundColor: Color(0xFFEFF1F3),
  dividerTheme: DividerThemeData(color: Colors.grey.withOpacity(0.1)),
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: primaryColor,
  ),
);

final textTheme = TextTheme(
  titleMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
  headlineLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
);
