import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/change_color.dart';
import 'package:riverpod_demo/change_number.dart';
import 'package:riverpod_demo/change_person.dart';
import 'package:riverpod_demo/state/providers.dart';

import 'models/person.dart';

// Only Stateful because of the NavigationBar's _selectedIndex
class Landing extends ConsumerStatefulWidget {
  const Landing({super.key});

  @override
  ConsumerState<Landing> createState() => _LandingState();
}

class _LandingState extends ConsumerState<Landing> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Color favColor = ref.watch(favColorStateProvider);
    int favNumber = ref.watch(favNumberStateProvider);
    Person favPerson = ref.watch(favPersonStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Landing"),
      ),
      body: [
        const ChangeColor(),
        const ChangeNumber(),
        const ChangePerson(),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(favColor.toString()),
                Container(
                  width: 50.0,
                  height: 25.0,
                  color: favColor,
                ),
              ],
            ),
            Text(favNumber.toString()),
            Text(favPerson.toString()),
            const ChangeNumber(),
          ],
        ),
      ][_selectedIndex],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.color_lens), label: "Color"),
          NavigationDestination(icon: Icon(Icons.numbers), label: "Number"),
          NavigationDestination(icon: Icon(Icons.person), label: "Person"),
          NavigationDestination(
              icon: Icon(Icons.question_answer), label: "Summary"),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
      ),
    );
  }
}
