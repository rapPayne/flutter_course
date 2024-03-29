// ignore_for_file: unused_import

import 'package:ch_5_gestures/all_the_buttons.dart';
import 'package:flutter/material.dart';
import 'manage_people.dart';
import 'add_person_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestures demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showHelp = false;
  List<Map<String, dynamic>> _people = [];
  _MyHomePageState() {
    _people = <Map<String, String>>[
      {"first": "Kevin", "last": "Malone"},
      {"first": "Kelly", "last": "Kapoor"},
      {"first": "Creed", "last": "Bratton"},
      {"first": "Dwight", "last": "Schrute"},
      {"first": "Andy", "last": "Bernard"},
      {"first": "Pam", "last": "Beasley"},
      {"first": "Jim", "last": "Halpert"},
      {"first": "Robert", "last": "California"},
      {"first": "David", "last": "Wallace"},
      {"first": "Erin", "last": ""},
      {"first": "Meredith", "last": "Palmer"},
      {"first": "Ryan", "last": "Howard"},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestures demo"),
      ),
      body: Stack(children: <Widget>[
        ManagePeople(
            people: _people,
            deletePerson: _deletePerson,
            addPerson: _addPerson,
            updatePerson: _updatePerson),
        (_showHelp == true) ? _helpDialog() : const Text(""),
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.help),
        onPressed: () => setState(() => _showHelp = !_showHelp),
      ),
    );
  }

  void _addPerson(BuildContext context) {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: AddPersonForm(
          addPerson: (Map<String, dynamic> newPerson) =>
              setState(() => _people.add(newPerson)),
        ),
      ),
    );
  }

  void _deletePerson(Map<String, dynamic> person, BuildContext context) {
    setState(() => _people.remove(person));
    debugPrint("Deleted ${person['first']}");
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Deleted ${person['first']}")));
  }

  void _updatePerson(Map<String, dynamic> person, {String status = ""}) {
    setState(() => person['status'] = status);
  }

  Widget _helpDialog() {
    const String helpText =
        "Swipe right to accept. Swipe left to reject. Unpinch to enter a new person. Long press to delete.";
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.help_outline),
              title: Text('How to use this widget'),
              subtitle: Text(helpText),
            ),
            // ButtonTheme.bar(
            //   child:
            ButtonBar(
              children: [
                TextButton(
                  child: const Text('DISMISS'),
                  onPressed: () => setState(() => _showHelp = !_showHelp),
                ),
              ],
            ),
            //),
          ],
        ),
      ),
    );
  }
}
