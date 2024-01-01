import 'package:flutter/material.dart';
import 'state.dart';
import 'state/movie.dart';
import 'date_picker.dart';
import 'film_brief.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  List<Movie>? films;

  @override
  void initState() {
    fetchFilms().then((f) => setState(() => films = f));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            children: [
              Image.asset("assets/daam.png", height: 75, fit: BoxFit.cover),
              Text(
                "Dinner And A Movie",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          const Text(
              "Tap a movie below to see its details. Then pick a date to see showtimes."),
          const DatePicker(),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: films == null
                  ? []
                  : films!
                      .map((f) => FilmBrief(
                            film: f,
                          ))
                      .toList(),
            ),
          ),
        ]),
      ),
    );
  }
}
