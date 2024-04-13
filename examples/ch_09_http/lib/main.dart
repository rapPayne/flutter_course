import 'package:ch_09_http/list_people.dart';
import 'package:ch_09_http/upsert_person.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme myColors = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
    ThemeData myTheme = ThemeData(
      colorScheme: myColors,
      appBarTheme: AppBarTheme(
        foregroundColor: myColors.surface,
        backgroundColor: myColors.primary,
      ),
      listTileTheme: ListTileThemeData(
        tileColor: myColors.surfaceVariant,
        iconColor: myColors.onSurface,
        contentPadding: const EdgeInsets.all(0.0),
        horizontalTitleGap: 0,
        enableFeedback: true,
      ),
      useMaterial3: true,
    );
    return MaterialApp(
      title: 'Ch 9 HTTP',
      theme: myTheme,
      routes: {
        '/': (_) => const ListPeople(),
        '/upsert': (_) => const UpsertPerson(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
