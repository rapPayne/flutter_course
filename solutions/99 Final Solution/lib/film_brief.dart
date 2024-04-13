import 'package:daam/showing_times.dart';
import 'package:daam/state.dart';
import 'package:raw_state/raw_state.dart';
import 'package:flutter/material.dart';
import 'state/movie.dart';

class FilmBrief extends StatelessWidget {
  final Movie film;
  const FilmBrief({required this.film, super.key});

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = rawState.get<DateTime>('selectedDate');
    return GestureDetector(
      onTap: () {
        rawState.set("selectedFilm", film);
        Navigator.pushNamed(context, '/film');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Image.network('${getBaseUrl()}/${film.posterPath}', height: 100),
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(children: [
                  Text(
                    film.title ?? "",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 5,
                    ),
                    child: Text(
                      film.tagline ?? "",
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ShowingTimes(
                    film: film,
                    selectedDate: selectedDate,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
