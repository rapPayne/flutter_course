import 'package:daam/ShowingTimes.dart';
import 'package:flutter/material.dart';
import 'Film.dart';

class FilmBrief extends StatelessWidget {
  final Film film;
  const FilmBrief({required this.film, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("FilmBrief"),
      Image.network("http://localhost:3007${film.poster_path}", height: 100),
      Text(film.title ?? ""),
      Text(film.tagline ?? ""),
      ShowingTimes(
        showings: [],
        film: film,
        selected_date: DateTime.now(),
      ),
    ]);
  }
}
