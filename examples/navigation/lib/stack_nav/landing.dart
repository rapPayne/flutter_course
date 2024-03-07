import 'package:flutter/material.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Landing")),
      body: Column(
        children: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/stack'),
            child: const Text("Stack navigation demo"),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/tabs'),
            child: const Text("Tab navigation demo"),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/drawer'),
            child: const Text("Drawer navigation demo"),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/subroutes'),
            child: const Text("Subroutes demo"),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/navigationbar'),
            child: const Text("Navigation bar demo"),
          ),
        ],
      ),
    );
  }
}
