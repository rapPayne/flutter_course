import 'package:daam/showing_times.dart';
import 'package:daam/state/film.dart';
import 'package:flutter/material.dart';

class FilmBrief extends StatelessWidget {
  final Film film; // <-- add this
  const FilmBrief({required this.film, super.key}); // <-- change this

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(film.title),
        const ShowingTimes(),
      ],
    );
  }
}
