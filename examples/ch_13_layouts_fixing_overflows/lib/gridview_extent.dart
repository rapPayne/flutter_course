import 'package:flutter/material.dart';
import 'dart:convert';
import 'person_card.dart';
import 'person.dart';

class GridViewExtent extends StatefulWidget {
  const GridViewExtent({super.key});

  @override
  State<GridViewExtent> createState() => _GridViewExtentState();
}

class _GridViewExtentState extends State<GridViewExtent> {
  List<Person> _peopleList = [];

  void _getPeople() async {
    String peopleString = await DefaultAssetBundle.of(context)
        .loadString('assets/data/people.json');
    Map<String, dynamic> jsonData = json.decode(peopleString);
    var ppl = jsonData['results']
        .map<Person>((p) => Person(
            imageUrl: p['picture']['large'],
            name:
                "${propercase(p['name']['first'])} ${propercase(p['name']['last'])}"))
        .toList();
    if (mounted) {
      setState(() => _peopleList = ppl);
    }
  }

  @override
  void initState() {
    super.initState();
    _getPeople();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // maxCrossAxisExtent: 300.0,
      crossAxisCount: 4,
      children: _peopleList
          .map<Widget>((Person person) => PersonCard(person))
          .toList(),
    );
  }
}

String propercase(String input) {
  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}
