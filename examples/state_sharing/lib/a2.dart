import 'package:flutter/material.dart';
import 'package:state_sharing/app_state.dart';
import 'package:state_sharing/superstate.dart';

class A2 extends StatefulWidget {
  const A2({super.key});

  @override
  State<A2> createState() => _A2State();
}

class _A2State extends State<A2> {
  late String first;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    first =
        (SuperState.of(context).appState.state as AppState).person?.first ?? "";
    _controller.text = first;
    _controller.selection =
        TextSelection.fromPosition(TextPosition(offset: first.length));

    return Center(
      child: Column(
        children: [
          Text("A2 $first"),
          TextField(
            onChanged: (val) {
              first = val;
              AppState state = SuperState.of(context).appState.state;
              SuperState.of(context)
                  .change(state.copyWith(person: Person()..first = val));
            },
            decoration: const InputDecoration(
              labelText: "First name",
            ),
            controller: _controller,
          ),
        ],
      ),
    );
  }
}
