import 'package:daam/date_picker.dart';
import 'package:daam/film_brief.dart';
import 'package:daam/state/film.dart';
import 'package:daam/state/repository.dart';
import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  List<Film> films = [];

  @override
  void initState() {
    fetchFilms().then((f) => setState(() => films = f));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text("Landing"),
          const DatePicker(),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: films
                  .map((f) => FilmBrief(
                        film: f,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
