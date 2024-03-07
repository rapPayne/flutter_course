import 'package:flutter/material.dart';
import 'package:navigation/stack_nav/stack1.dart';
import 'package:navigation/stack_nav/stack2.dart';
import 'package:navigation/stack_nav/stack3.dart';

class SubroutesDemo extends StatelessWidget {
  const SubroutesDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subroutes demo"),
      ),
      body: Navigator(
        onGenerateRoute: (settings) {
          if (settings.name == "/foo/stack1") {
            return MaterialPageRoute(builder: (context) => const Stack1());
          }
          if (settings.name == "/foo/stack2") {
            return MaterialPageRoute(builder: (context) => const Stack2());
          }
          if (settings.name == "/foo/stack3") {
            return MaterialPageRoute(builder: (context) => const Stack3());
          }
          return MaterialPageRoute(builder: (context) => const SubroutesDemo());
        },
      ),
    );
  }
}
