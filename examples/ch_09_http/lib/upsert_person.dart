import 'package:ch_09_http/data/people.dart';
import 'package:ch_09_http/types/person.dart';
import 'package:flutter/material.dart';

class UpsertPerson extends StatefulWidget {
  const UpsertPerson({super.key});

  @override
  State<UpsertPerson> createState() => _UpsertPersonState();
}

class _UpsertPersonState extends State<UpsertPerson> {
  late Person person;
  @override
  Widget build(BuildContext context) {
    // Get the 'current' person set during navigation. If
    // this person is null, we're adding a new person and
    // we must instantiate one. If this person is not null,
    // then we're updating that person.
    Person? routePerson = ModalRoute.of(context)?.settings.arguments as Person?;
    person = (routePerson == null) ? Person() : routePerson;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (person.id == null) ? 'Add a person' : 'Update a person',
        ),
      ),
      body: _body,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Save the person
          upsertPerson(person);
          // And go back to where we came from
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  Widget get _body {
    return Form(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextFormField(
                initialValue: person.name,
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (val) => person.name = val),
            TextFormField(
                initialValue: person.phone,
                decoration: const InputDecoration(labelText: 'Phone'),
                onChanged: (val) => person.phone = val),
            TextFormField(
                initialValue: person.email,
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (val) => person.email = val),
          ],
        ),
      ),
    );
  }
}
