import 'package:ch_12_layouts_fixing_overflows/person.dart';
import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final Person person;
  const PersonCard(this.person, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4.0),
      child: Stack(
        children: <Widget>[
          Image.network(
            person.imageUrl,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.0, -2.0),
                    end: Alignment(0.0, 1.0),
                    colors: <Color>[
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                  ),
                ),
                child: Text(
                  person.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
