import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/models/person.dart';
import 'package:riverpod_demo/state/providers.dart';

class ChangePerson extends ConsumerStatefulWidget {
  const ChangePerson({super.key});

  @override
  ConsumerState<ChangePerson> createState() => _ChangePersonState();
}

class _ChangePersonState extends ConsumerState<ChangePerson> {
  String _first = '';
  String _last = '';
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late Person person;

  @override
  Widget build(BuildContext context) {
    // person = ref.watch(favPersonStateNotifierProvider);
    person = ref.watch(favPersonStateProvider);

    _first = person.first;
    _last = person.last;
    return Form(
      key: _key,
      child: Column(children: [
        TextFormField(
          initialValue: _first,
          onSaved: (newValue) => _first = newValue!,
          decoration: const InputDecoration(label: Text("First name")),
        ),
        TextFormField(
          initialValue: _last,
          onChanged: (newValue) => _last = newValue,
          decoration: const InputDecoration(label: Text("Last name")),
        ),
        ElevatedButton(
          onPressed: () => _savePerson(person),
          child: const Text("Save"),
        ),
        Text("$_first $_last"),
      ]),
    );
  }

  void _savePerson(person) {
    _key.currentState!.save();
    // setState(
    //   () {
    //     ref.read(favPersonStateNotifierProvider.notifier).setFirst(_first);
    //     ref.read(favPersonStateNotifierProvider.notifier).setLast(_last);
    //   },
    // );
    setState(
      () {
        Person p = person.copyWith(first: _first, last: _last);
        ref.read(favPersonStateProvider.notifier).state = p;
      },
    );
  }
}
