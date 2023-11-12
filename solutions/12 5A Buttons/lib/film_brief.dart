import 'package:daam/showing_times.dart';
import 'package:daam/state/film.dart';
import 'package:daam/state/repository.dart';
import 'package:flutter/material.dart';

class FilmBrief extends StatelessWidget {
  final Film film;
  const FilmBrief({required this.film, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          '${getBaseUrl()}/${film.posterPath}',
          height: 100,
          fit: BoxFit.contain,
        ),
        Text(film.title),
        Text(film.tagline ?? ""),
        ShowingTimes(film: film, selectedDate: DateTime.now()),
      ],
    );
  }
}
