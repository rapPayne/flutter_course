// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:state_sharing/main.dart';

class A1 extends StatefulWidget {
  const A1({super.key});

  @override
  State<A1> createState() => _A1State();
}

class _A1State extends State<A1> {
  TopWidget? rootWidget;
  FirstNameService? fns;
  String first = "";
  final TextEditingController _controller = TextEditingController();
  @override
  void didChangeDependencies() {
    print("A1 dcd is running");

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    rootWidget = TopWidget.of(context);

    fns = rootWidget!.firstNameService;
    print("A1 builder is running");
    assert(
        rootWidget != null, "Inconceivable! RootWidget cannot be null here.");
    first = rootWidget!.firstNameService.first;
    _controller.text = first;
    return ListenableBuilder(
        listenable: fns!,
        builder: (context, child) {
          return Center(
            child: Column(
              children: [
                Text("A1 $first"),
                TextField(
                  onChanged: (val) => first = val,
                  decoration: const InputDecoration(
                    labelText: "First name",
                  ),
                  controller: _controller,
                ),
                TextButton(
                  onPressed: () =>
                      rootWidget!.firstNameService.setFirst("Test"),
                  child: const Text("Update"),
                ),
              ],
            ),
          );
        });
  }
}
