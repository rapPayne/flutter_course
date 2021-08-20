import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state.dart';
import 'Film.dart';
import 'ShowingTimes.dart';

class FilmDetails extends StatefulWidget {
  const FilmDetails({Key? key}) : super(key: key);

  @override
  _FilmDetailsState createState() => _FilmDetailsState();
}

class _FilmDetailsState extends State<FilmDetails> {
  Film film = Film();
  DateTime selected_date = DateTime.now();
  List<dynamic> showings = [];

  @override
  void initState() {
    super.initState();
    // Read the currently selected film from state. If there isn't one, use film id of 1.
    film = context.read(selectedFilmProvider).state ?? Film()
      ..id = 1;
    // Read the currently selected date. Use today if no date has been selected yet.
    selected_date = context.read(selectedDateProvider).state ?? DateTime.now();
    fetchFilm(id: 1).then((f) => setState(() {
          context.read(selectedFilmProvider).state = f;
        }));
    // Ask the API server for all of the showings for the selected film and date.
    fetchShowings(film_id: film.id, date: selected_date)
        .then((s) => setState(() => context.read(showingsProvider).state = s));
  }

  @override
  Widget build(BuildContext context) {
    film = context.read(selectedFilmProvider).state ?? Film();
    showings = context.read(showingsProvider).state;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Image.network("http://localhost:3007/" + (film.poster_path ?? "")),
          ShowingTimes(
            film: film,
            showings: showings,
            selected_date: selected_date,
          ),
          Text(film.title ?? ""),
          Text(film.tagline ?? ""),
          Text(film.homepage ?? ""),
          Text(film.overview ?? ""),
          Text("Rating: ${film.vote_average}/10 ${film.vote_count} votes"),
        ],
      )),
    );
  }
}
