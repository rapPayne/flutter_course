import 'package:daam/showing_times.dart';
import 'package:daam/state/film.dart';
import 'package:daam/state/repository.dart';
import 'package:flutter/material.dart';
import 'package:raw_state/raw_state.dart';

class FilmBrief extends StatelessWidget {
  const FilmBrief({required this.film, required this.selectedDate, super.key});
  final DateTime selectedDate;
  final Film film;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        rawState.set("selectedFilm", film);
        Navigator.pushNamed(context, "/film");
      },
      child: Row(
        children: [
          Image.network(
            '${getBaseUrl()}/${film.posterPath}',
            height: 100,
            fit: BoxFit.contain,
          ),
          Column(
            children: [
              Text(film.title),
              Text(film.tagline ?? ""),
              ShowingTimes(film: film, selectedDate: selectedDate),
            ],
          ),
        ],
      ),
    );
  }
}
