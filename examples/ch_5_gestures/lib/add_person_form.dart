import 'package:flutter/material.dart';

class AddPersonForm extends StatefulWidget {
  final Function addPerson;
  const AddPersonForm({super.key, required this.addPerson});
  @override
  State<AddPersonForm> createState() => _AddPersonFormState();
}

class _AddPersonFormState extends State<AddPersonForm> {
  final _person = <String, String>{};

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child:
          // Container(
          //   child:
          Column(
        children: <Widget>[
          Text("Add a new person",
              style: Theme.of(context).textTheme.headlineMedium),
          _buildFirstNameText(),
          _buildLastNameText(),
          ElevatedButton(
            onPressed: () => _savePerson(context),
            child: const Text("Save"),
          )
        ],
      ),
      //),
    );
  }

  void _savePerson(BuildContext context) {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      debugPrint("Save ${_person['first']} here");
      widget.addPerson(_person);
      Navigator.pop(context, true);
    }
  }

  Widget _buildFirstNameText() {
    return TextFormField(
      onSaved: (val) {
        _person['first'] = val ?? '';
      },
      decoration: const InputDecoration(labelText: "First name"),
      validator: (val) =>
          (val != null && val.isEmpty) ? "We need a first name, please" : null,
    );
  }

  Widget _buildLastNameText() {
    return TextFormField(
      onSaved: (val) => _person['last'] = val ?? "",
      decoration: const InputDecoration(labelText: "Last name"),
      validator: (val) =>
          (val != null && val.isEmpty) ? "We need a last name, please" : null,
    );
  }
}
