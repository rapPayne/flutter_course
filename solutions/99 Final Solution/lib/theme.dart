import 'package:flutter/material.dart';

var _colorScheme = ColorScheme.fromSeed(
  seedColor: Colors.purple,
); //.copyWith(error: Color.fromARGB(255, 255, 100, 232));

TextTheme _textTheme = const TextTheme().copyWith(
  bodyLarge: const TextStyle()
      .copyWith(color: const Color.fromARGB(255, 30, 233, 135)),
  titleMedium: TextStyle(color: _colorScheme.primary),
  labelLarge: const TextStyle()
      .copyWith(color: const Color.fromARGB(255, 30, 233, 135)),
);

var themeData = ThemeData(
  colorScheme: _colorScheme,
  textTheme: _textTheme,
  useMaterial3: true,
);
