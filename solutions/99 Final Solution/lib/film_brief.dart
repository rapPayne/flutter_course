import 'package:daam/showing_times.dart';
import 'package:daam/state.dart';
import 'package:flutter/material.dart';
import 'state/Film.dart';
import 'state/AppState.dart';
import 'state/SuperState.dart';

class FilmBrief extends StatelessWidget {
  final Film film;
  const FilmBrief({required this.film, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SuperState _ss = SuperState.of(context);
    AppState _state = _ss.state;

    return GestureDetector(
      onTap: () {
        _state.selectedFilm = film;
        //TODO: Write to state
        Navigator.pushNamed(context, '/film');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Image.network('${getBaseUrl()}/${film.poster_path}', height: 100),
            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(children: [
                  Text(
                    film.title ?? "",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Container(
                    margin: EdgeInsets.only(
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
                    selected_date: _state.selectedDate,
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
