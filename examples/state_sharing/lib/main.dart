import 'package:flutter/material.dart';
import 'package:state_sharing/a.dart';
import 'package:state_sharing/app_state.dart';
import 'package:state_sharing/superstate.dart';

void main(List<String> args) {
  runApp(const Root());
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    AppState appState = AppState(person: Person()..first = 'Rap');

    return SuperState<AppState>(
      initialState: appState,
      child: MaterialApp(
        theme: ThemeData.from(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
        home: const A(),
      ),
    );
  }
}
