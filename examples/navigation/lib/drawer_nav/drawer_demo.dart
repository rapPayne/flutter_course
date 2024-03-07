import 'package:flutter/material.dart';
import 'package:navigation/drawer_nav/the_drawer.dart';

class DrawerDemo extends StatelessWidget {
  const DrawerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drawer Navigation")),
      drawer: const Drawer(
        child: TheDrawer(),
      ),
      body: const Column(
        children: [
          Text("Drawer Navigation"),
        ],
      ),
    );
  }
}
