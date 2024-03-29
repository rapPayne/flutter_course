import 'package:flutter/material.dart';

class NavigationBarDemo extends StatefulWidget {
  const NavigationBarDemo({super.key});

  @override
  State<NavigationBarDemo> createState() => _NavigationBarDemoState();
}

class _NavigationBarDemoState extends State<NavigationBarDemo> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Navigation Bar Demo')),
        body: Column(
          children: [
            _bodyWidgets[_selectedIndex],
            const Spacer(),
            NavigationBar(
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.explore),
                  label: 'Explore',
                ),
                NavigationDestination(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
              selectedIndex: _selectedIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            )
          ],
        ));
  }

  final List<Widget> _bodyWidgets = [
    const Text("Tab 1 - Home"),
    const Text("Tab 2 - Explore"),
    const Text("Tab 3 - Settings"),
  ];
}
