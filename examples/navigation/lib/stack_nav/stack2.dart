import 'package:flutter/material.dart';
import 'stack1.dart';
import 'stack3.dart';

class Stack2 extends StatelessWidget {
  const Stack2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stack2")),
      body: Column(
        children: [
          const Text("Stack2", style: TextStyle(fontWeight: FontWeight.bold)),
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
        ],
      ),
    );
  }
}
