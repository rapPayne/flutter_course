import 'package:flutter/material.dart';
import 'package:navigation/drawer_nav/drawer_demo.dart';
import 'package:navigation/stack_nav/landing.dart';
import 'package:navigation/navigation_bar_demo.dart';
import 'package:navigation/stack_nav/stack1.dart';
import 'package:navigation/subroutes/subroutes_demo.dart';
import 'package:navigation/tab_nav/tabs_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (_) => const Landing(),
        '/stack': (_) => const Stack1(),
        '/tabs': (_) => const TabsDemo(),
        '/drawer': (_) => const DrawerDemo(),
        '/subroutes': (_) => const SubroutesDemo(),
        '/navigationbar': (_) => const NavigationBarDemo(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
