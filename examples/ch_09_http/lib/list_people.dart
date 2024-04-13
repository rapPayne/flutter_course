import 'package:ch_09_http/data/people.dart';
import 'package:ch_09_http/person_widget.dart';
import 'package:flutter/material.dart';
import 'types/person.dart';

class ListPeople extends StatefulWidget {
  const ListPeople({super.key});

  @override
  State<ListPeople> createState() => _ListPeopleState();
}

class _ListPeopleState extends State<ListPeople> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People'),
      ),
      body: scaffoldBody,
      floatingActionButton: FloatingActionButton(
        // An Add button. When the user taps it, we send
        // them to PeopleUpsert with NO person object.
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/upsert');
        },
      ),
    );
  }

  // Note how we pull out details to make the widget more
  // abstract for you. We do the same with PersonWidget below.
  Widget get scaffoldBody {
    return FutureBuilder<dynamic>(
      future: fetchPeople(), // How we'll get the people
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          return Text('Oh no! Error! ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return const Text('No people found');
        }
        // Convert the JSON data to an array of Persons
        List<Person> people = Person.fromJsonArray(snapshot.data.body);
        // Convert the list of persons to a list of widgets
        List<Widget> personTiles = people
            .map<Widget>((Person person) => PersonWidget(
                person: person,
                editPerson: () => setState(() {
                      Navigator.of(context)
                          .pushNamed('/upsert', arguments: person);
                    })))
            .toList();
        // Display all the person tiles in a scrollable GridView
        return ListView(
          children: personTiles,
        );
      },
    );
  }
}
