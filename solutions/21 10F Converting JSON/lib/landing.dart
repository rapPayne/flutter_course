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
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    fetchFilms().then((f) => setState(() => films = f));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/daam.png',
              height: 75,
              fit: BoxFit.contain,
            ),
            const Text("Dinner and a Movie"),
            const Text(
                "Tap a movie below to see its details. Then pick a date to see showtimes"),
            DatePicker(
              setSelectedDate: setSelectedDate,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: films
                    .map((f) => FilmBrief(
                          film: f,
                          selectedDate: selectedDate,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setSelectedDate(DateTime newSelectedDate) {
    setState(() => selectedDate = newSelectedDate);
  }
}
