// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:state_sharing/superstate.dart';

////////////////////////////////////////////////////////
/// All the stuff the user should write
////////////////////////////////////////////////////////
void main() {
  runApp(const UsersApp());
}

// class UsersState {
//   int counter = 0;
//   String first = "";

//   UsersState copyWith({int? counter, String? first}) {
//     return UsersState()
//       ..counter = counter ?? this.counter
//       ..first = first ?? this.first;
//   }
// }

class UsersState {
  final int counter;
  final String first;
  UsersState({required this.counter, required this.first});

  UsersState copyWith({int? counter, String? first}) {
    return UsersState(
        counter: counter ?? this.counter, first: first ?? this.first);
  }
}

class UsersApp extends StatelessWidget {
  const UsersApp({super.key});
  @override
  Widget build(BuildContext context) {
    UsersState usersState = UsersState(counter: 10, first: "Simon");
    // StateWrapper<UsersState> appState =
    //     StateWrapper<UsersState>(state: usersState);

    return SuperState<UsersState>(
      initialState: usersState,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const Scaffold(
          appBar: UsersAppBar(),
          body: Center(
            child: UsersCounterDisplay(),
          ),
          floatingActionButton: UsersCounterAddButton(),
        ),
      ),
    );
  }
}

class UsersAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UsersAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    UsersState state = SuperState.of(context).appState.state;
    return AppBar(
      title: Text("App: '${state.first}'"),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class UsersCounterAddButton extends StatelessWidget {
  const UsersCounterAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        UsersState oldState = SuperState.of(context).appState.state;
        var newState = oldState.copyWith(counter: oldState.counter + 1);
        SuperState.of(context).change(newState);
      },
      child: const Icon(Icons.add),
    );
  }
}

class UsersCounterDisplay extends StatelessWidget {
  const UsersCounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    UsersState state = SuperState.of(context).appState.state;
    print('build display $state');
    return Column(
      children: [
        Text(
          'Count: ${state.counter}',
          style: theme.textTheme.displaySmall,
        ),
        Text("First: ${state.first}"),
        const UsersFirstTextInput(),
      ],
    );
  }
}

class UsersFirstTextInput extends StatefulWidget {
  const UsersFirstTextInput({super.key});

  @override
  State<UsersFirstTextInput> createState() => _UsersFirstTextInputState();
}

class _UsersFirstTextInputState extends State<UsersFirstTextInput> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var state = SuperState.of(context).appState.state;
    _controller.text = state.first;
    _controller.selection =
        TextSelection.fromPosition(TextPosition(offset: state.first.length));
    return Column(
      children: [
        const Text("First name is"),
        TextField(
          controller: _controller,
          onChanged: (String value) {
            UsersState newState =
                SuperState.of(context).appState.state.copyWith(first: value);
            SuperState.of(context).change(newState);
          },
        )
      ],
    );
  }
}
