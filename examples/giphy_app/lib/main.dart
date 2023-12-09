// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:giphy_app/draw_random_gif.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Random Giphy Viewer',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme.light().copyWith(primary: Colors.red),
        ),
        home: const DrawRandomGif());
  }
}
