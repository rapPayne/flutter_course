// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:state_sharing/a1.dart';
import 'package:state_sharing/a2.dart';
import 'package:state_sharing/app_state.dart';
import 'package:state_sharing/superstate.dart';

class A extends StatefulWidget {
  const A({super.key});

  @override
  State<A> createState() => _AState();
}

class _AState extends State<A> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String first =
        (SuperState.of(context).appState.state as AppState).person?.first ?? "";
    _controller.text = first;
    print("A builder is running. first is '$first'");

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
          ],
        ),
      ),
    );
  }
}
