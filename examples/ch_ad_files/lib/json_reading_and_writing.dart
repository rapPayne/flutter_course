import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'layout_drawer.dart';
import 'dart:io';
import 'dart:convert';

class JsonReadingAndWriting extends StatefulWidget {
  const JsonReadingAndWriting({super.key});

  @override
  State<JsonReadingAndWriting> createState() => _JsonReadingAndWritingState();
}

class _JsonReadingAndWritingState extends State<JsonReadingAndWriting> {
  final String _assetFilename = "database.json";
  String _filename = "database.json";
  String _message = "";
  EditingStatus _editingStatus = EditingStatus.none;
  Person _person = Person();
  bool _errorStatus = false;
  late TextEditingController _controller;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // To keep this demo more understandable, we made this a Map
  // but in practice, it would have been a Person class/object.
  List<Person> _people = [];

  @override
  void initState() {
    _controller = TextEditingController(text: _filename);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LayoutAppBar().toPreferredSizeWidget(context),
      drawer: const LayoutDrawer(),
      body: _body,
    );
  }

  Widget get _body {
    TextStyle messageStyle = _errorStatus
        ? const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)
        : Theme.of(context).textTheme.bodyMedium!;
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: <Widget>[
          Text("Reading and writing JSON from $_filename"),
          ElevatedButton(
            onPressed: _refreshAssetsFile,
            child: const Text('Refresh the database file'),
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Filename"),
            controller: _controller,
            onChanged: (value) {
              setState(() {
                _filename = value;
              });
            },
          ),
          ElevatedButton(
            onPressed: _loadDatabaseFile,
            child: const Text("Load the database file"),
          ),
          DropdownButton<Person>(
            items: _people.map((Person person) {
              return DropdownMenuItem<Person>(
                value: person,
                child: Text('${person.firstName} ${person.lastName}'),
              );
            }).toList(),
            onChanged: (p) => _selectCurrentPerson(p ?? Person()),
          ),
          if (_editingStatus == EditingStatus.none)
            ElevatedButton(
              onPressed: _prepareAddPerson,
              child: const Text("Add New Person"),
            ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: "First name"),
                  onSaved: (value) {
                    setState(() {
                      _person.firstName = value ?? "";
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Last name"),
                  onSaved: (value) {
                    setState(() {
                      _person.lastName = value ?? "";
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Occupation"),
                  onSaved: (value) {
                    setState(() {
                      _person.occupation = value ?? "";
                    });
                  },
                ),
              ],
            ),
          ),
          if (_editingStatus == EditingStatus.adding)
            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: _savePerson,
                  child: const Text("Save"),
                ),
                ElevatedButton(
                  onPressed: _cancel,
                  child: const Text("Cancel"),
                ),
              ],
            )
          else if (_editingStatus == EditingStatus.modifying)
            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: _savePerson,
                  child: const Text("Save"),
                ),
                ElevatedButton(
                  onPressed: _cancel,
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: _deletePerson,
                  child: const Text("Delete"),
                ),
              ],
            ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: Text(
              _message,
              style: messageStyle,
            ),
          ),
        ],
      ),
    );
  }

  // Clears out the textboxes so a brand new person can be added to the list
  void _prepareAddPerson() {
    setState(() {
      _editingStatus = EditingStatus.adding;
      _person = Person();
    });
  }

  void _cancel() {
    _formKey.currentState?.reset();
    setState(() {
      _editingStatus = EditingStatus.none;
      _person = Person();
    });
  }

  void _selectCurrentPerson(Person person) {
    setState(() {
      _editingStatus = EditingStatus.modifying;
      _person = person;
      debugPrint("Selected $_person");
    });
  }

  // Upserts the current person to the list of people. ie. If the person doesn't exist
  // already, add them. If they do exist, update them.
  void _savePerson() {
    setState(() {
      _formKey.currentState?.save();
      if (_editingStatus == EditingStatus.adding) {
        _person.id = const Uuid().v1();
        _people.add(_person);
      }
      // Not sure we have to do anything; we're already putting the names and stuff into _person which is a reference to the person in memory.
      //else
      //Person thePerson = _people.firstWhere((Person p) => p.id == _person.id);

      _editingStatus = EditingStatus.none;
      _formKey.currentState?.reset();
      _saveDatabaseFile();
    });
  }

  // Delete a person from the list of people.
  void _deletePerson() {
    //_saveDatabaseFile();
  }

  // Read from the assets file and load it into the local 'database' file.
  void _refreshAssetsFile() async {
    String stringData = await rootBundle.loadString('assets/$_assetFilename');
    Directory documents = await getApplicationDocumentsDirectory();
    _errorStatus = false;
    File file = File('${documents.path}/$_filename');
    try {
      await file.writeAsString(stringData);
      setState(() {
        _message = '$_filename now has this text inside it: "$stringData"';
      });
    } catch (ex) {
      setState(() {
        _errorStatus = true;
        _message = 'Error: $ex';
      });
    }
  }

  // Reads from a flat 'database' file in JSON format and saves to state (_person)
  void _loadDatabaseFile() async {
    Directory documents = await getApplicationDocumentsDirectory();
    _errorStatus = false;
    File file = File('${documents.path}/$_filename');
    file.readAsString().then((String text) {
      setState(() {
        _message = '$_filename has this text inside it: "$text"';
        Map<String, dynamic> db = json.decode(text);
        List<dynamic> ppl = db["people"];
        _people = ppl
            .map((dynamic p) => Person(
                id: p["id"],
                firstName: p["firstName"],
                lastName: p["lastName"],
                occupation: p["occupation"]))
            .toList();
      });
    }).catchError((Object e) {
      setState(() {
        _errorStatus = true;
        _message = 'Error: $e';
      });
    });
  }

  void _saveDatabaseFile() async {
    Directory documents = await getApplicationDocumentsDirectory();
    setState(() {
      _errorStatus = false;
    });
    File file = File('${documents.path}/$_filename');
    Map<String, dynamic> jsonObject = <String, dynamic>{"people": _people};

    try {
      await file.writeAsString(json.encode(jsonObject));
    } catch (e) {
      debugPrint("Problem serializing: $e");
      setState(() {
        _errorStatus = true;
        _message = 'Error: $e';
      });
    }
  }
}

class Person {
  String? id;
  String? firstName;
  String? lastName;
  String? occupation;

  Person({this.id, this.firstName, this.lastName, this.occupation});

  @override
  String toString() {
    return json.encode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id ?? "",
        "firstName": firstName ?? '',
        "lastName": lastName ?? '',
        "occupation": occupation ?? ''
      };
}

enum EditingStatus { none, adding, modifying }
