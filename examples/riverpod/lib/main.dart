import 'package:flutter/material.dart';
import 'package:riverpod_demo/change_color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'landing.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        "/": (_) => const Landing(),
        "/changeColor": (_) => const ChangeColor(),
      },
    );
  }
}
