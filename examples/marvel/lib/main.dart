import 'package:flutter/material.dart';
import 'package:marvel/characters/character_scene.dart';
import 'characters/marvel_characters_lookup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel Lookup',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => const Lookup(),
        '/character': (ctx) => const CharacterScene(),
      },
    );
  }
}
