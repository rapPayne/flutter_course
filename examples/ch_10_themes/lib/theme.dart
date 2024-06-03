import 'package:flutter/material.dart';

ColorScheme _colorScheme = ColorScheme.fromSeed(
  seedColor: Colors.green,
).copyWith(
  error: const Color.fromARGB(255, 191, 87, 0),
  onError: Colors.white,
);

TextTheme _textTheme = const TextTheme().copyWith(
  bodyMedium: const TextStyle().copyWith(fontSize: 18.0),
  displayLarge: const TextStyle(),
);

// Widget-specific themes
AppBarTheme _appBarTheme = const AppBarTheme().copyWith(
    foregroundColor: _colorScheme.onTertiaryContainer,
    color: _colorScheme.tertiary,
    titleTextStyle: _textTheme.displayLarge!.copyWith(fontFamily: 'Courier'));
ListTileThemeData _listTileThemeData = const ListTileThemeData().copyWith(
    tileColor: _colorScheme.secondary,
    textColor: _colorScheme.onSecondary,
    contentPadding: const EdgeInsets.all(10.0));

var themeData = ThemeData(
  colorScheme: _colorScheme,
  textTheme: _textTheme,
  // Widget-specific themes only when needed
  appBarTheme: _appBarTheme,
  listTileTheme: _listTileThemeData,
  // Optionally set other specialized things here
  fontFamily: 'Courier',
  fontFamilyFallback: const ['monospace', 'serif'],
);
