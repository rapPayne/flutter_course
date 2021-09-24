import 'package:daam/ShowingTimes.dart';
import 'package:daam/state.dart';
import 'package:flutter/material.dart';
import 'Film.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state.dart';

class FilmBrief extends StatelessWidget {
  final Film film;
  const FilmBrief({required this.film, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read(selectedFilmProvider).state = film;
        Navigator.pushNamed(context, "/details");
      },
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.all(10.0),
              child: Image.network("${getBaseUrl()}/${film.poster_path}",
                  height: 100)),
          Flexible(
            child: Column(children: [
              Text(film.title ?? ""),
              Text(film.tagline ?? ""),
              ShowingTimes(
                showings: [],
                film: film,
                selected_date: DateTime.now(),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
