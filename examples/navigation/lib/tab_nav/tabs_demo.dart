import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lorem_gen/lorem_gen.dart';

class TabsDemo extends StatefulWidget {
  const TabsDemo({super.key});

  @override
  State<TabsDemo> createState() => _TabsDemoState();
}

class _TabsDemoState extends State<TabsDemo> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tab Navigation Demo'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.looks_one)),
              Tab(icon: Icon(Icons.looks_two)),
              Tab(icon: Icon(Icons.looks_3)),
              Tab(icon: Icon(Icons.looks_4)),
              Tab(icon: Icon(Icons.looks_5)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Content(icon: Icons.looks_one, word: "one"), // Content for tab 1
            Content(icon: Icons.looks_two, word: "two"), // Content for tab 2
            Content(icon: Icons.looks_3, word: "three"), // Content for tab 3
            Content(icon: Icons.looks_4, word: "four"), // Content for tab 4
            Content(icon: Icons.looks_5, word: "five"), // Content for tab 5
          ],
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({super.key, required this.icon, required this.word});
  final IconData icon;
  final String word;

  @override
  Widget build(BuildContext context) {
    Color randomColor = Colors.primaries[Random().nextInt(Colors.primaries
        .length)]; // Select a random color from the predefined `Colors.primaries` list
    return Column(
      children: [
        const Spacer(),
        Icon(
          icon,
          size: 200.0,
          color: randomColor,
        ),
        Text(
          "This is view $word",
          style: const TextStyle(fontSize: 30.0),
        ),
        const Spacer(flex: 2),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            Lorem.paragraph(),
            style: TextStyle(fontSize: 24.0, color: randomColor),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
