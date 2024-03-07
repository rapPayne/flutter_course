import 'package:flutter/material.dart';

class TheDrawer extends StatelessWidget {
  const TheDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      indicatorColor: Colors.red,
      backgroundColor: Colors.blue.shade100,
      children: [
        const DrawerHeader(child: Text("The Drawer")),
        DrawerButton(
          // ignore: avoid_print
          onPressed: () => print("button pressed"),
        ),
        ListTile(
          leading: const Icon(Icons.file_copy_sharp),
          title: const Text("Stack Navigation"),
          subtitle: const Text("A demo for stack navigation"),
          onTap: () => Navigator.pushNamed(context, '/stack'),
        ),
        ListTile(
          leading: const Icon(Icons.tab),
          title: const Text("Tab Navigation"),
          subtitle: const Text("Demonstrating tabs"),
          onTap: () => Navigator.pushNamed(context, '/tabs'),
        ),
      ],
    );
  }
}
