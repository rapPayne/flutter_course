// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:state_sharing/app_state.dart';
import 'package:state_sharing/superstate.dart';

class A1 extends StatefulWidget {
  const A1({super.key});

  @override
  State<A1> createState() => _A1State();
}

class _A1State extends State<A1> {
  String first = "";
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String first =
        (SuperState.of(context).appState.state as AppState).person?.first ?? '';
    print("A1 builder is running. First is '$first'");
    _controller.text = first;
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
            onPressed: () {
              AppState oldState = SuperState.of(context).appState.state;
              AppState newState = AppState(
                  cart: oldState.cart,
                  creditCard: oldState.creditCard,
                  person: Person()..first = 'Set in A1 btn click');
              SuperState.of(context).change(newState);
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }
}
