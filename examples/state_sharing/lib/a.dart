import 'package:flutter/material.dart';
import 'package:state_sharing/main.dart';

import 'a1.dart';
import 'a2.dart';
import 'a3.dart';

class A extends StatefulWidget {
  final String foo;
  const A({super.key, required this.foo});

  @override
  State<A> createState() => _AState();
}

class _AState extends State<A> {
  TopWidget? rootWidget;
  FirstNameService? fns;
  String first = "Becky";
  final TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("A builder is running");
    rootWidget = TopWidget.of(context);
    assert(
        rootWidget != null, "Inconceivable! RootWidget cannot be null here.");
    fns = rootWidget!.firstNameService;
    first = fns!.first;
    _controller.text = first;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("A $first"),
            TextField(
              onChanged: (val) => first = val,
              decoration: const InputDecoration(
                labelText: "First name",
              ),
              controller: _controller,
            ),
            const A1(),
            const A2(),
            const A3(),
          ],
        ),
      ),
    );
    return const Column(
      children: [],
    );
  }
}
