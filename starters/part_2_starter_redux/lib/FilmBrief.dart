import 'ShowingTimes.dart';
import 'package:flutter/material.dart';
import 'Film.dart';
import 'store/store.dart';
import 'store/Actions.dart' as daam_Actions;

class FilmBrief extends StatelessWidget {
  final Film film;
  const FilmBrief({required this.film, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //context.read(selectedFilmProvider).state = film;
        store.dispatch(
            {'type': daam_Actions.Actions.SET_SELECTED_FILM, 'film': film});

        Navigator.pushNamed(context, "/details");
      },
      child: Row(
        children: [
          Image.network("${getBaseUrl()}/${film.poster_path}", height: 100),
          Column(children: [
            Text(film.title ?? ""),
            Text(film.tagline ?? ""),
            ShowingTimes(
              showings: [],
              film: film,
              selected_date: DateTime.now(),
            ),
          ]),
        ],
      ),
    );
  }
}
