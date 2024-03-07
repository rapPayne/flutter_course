import 'package:flutter/material.dart';
import 'package:navigation/drawer_nav/drawer_demo.dart';
import 'stack1.dart';
import 'stack2.dart';

class Stack3 extends StatelessWidget {
  const Stack3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stack3")),
      body: Column(
        children: [
          const Text("Stack3", style: TextStyle(fontWeight: FontWeight.bold)),
          ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => const Stack1())),
              child: const Text("Stack 1")),
          ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => const Stack2())),
              child: const Text("Stack 2")),
          ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => const Stack3())),
              child: const Text("Stack 3")),
          ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => const DrawerDemo())),
              child: const Text("Drawer Navigation")),
        ],
      ),
    );
  }
}
