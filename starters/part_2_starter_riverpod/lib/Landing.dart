import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state.dart';
import 'Film.dart';
import 'DatePicker.dart';
import 'FilmBrief.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    List<Film> films = context.read(filmsProvider).state;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(children: [
          Row(
            children: [
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: Image.asset("assets/daam.png",
                      height: 75, fit: BoxFit.cover)),
              Text("Dinner And A Movie",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
                "Tap a movie below to see its details. Then pick a date to see showtimes."),
          ),
          DatePicker(),
          Column(
            children: films
                .map((f) => FilmBrief(
                      film: f,
                    ))
                .toList(),
          ),
        ])),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchFilms().then((films) => context.read(filmsProvider).state = films);
  }
}
