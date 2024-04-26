import './theme.dart';
import 'package:ch_10_themes/dashboard.dart';
import 'package:ch_10_themes/text_theme_demo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Themes and Styles Demo',
      theme: themeData,
      initialRoute: "/",
      routes: {
        "/": (_) => const Dashboard(title: "Dashboard"),
        "/textThemeDemo": (_) => const Scaffold(body: TextThemeDemo()),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
