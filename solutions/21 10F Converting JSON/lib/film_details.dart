import 'package:daam/showing_times.dart';
import 'package:daam/state/film.dart';
import 'package:flutter/material.dart';
import 'package:raw_state/raw_state.dart';

class FilmDetails extends StatelessWidget {
  const FilmDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Film selectedFilm = rawState.get<Film>("selectedFilm");
    DateTime selectedDate = rawState.get<DateTime>("selectedDate");

    return SingleChildScrollView(
      child: Column(
        children: [
          const Text("FilmDetails"),
          Image.network("http://localhost:3008/${selectedFilm.posterPath}"),
          ShowingTimes(
            film: selectedFilm,
            selectedDate: selectedDate,
          ),
          Text(
            selectedFilm.title,
          ),
          Text(
            selectedFilm.tagline ?? "",
          ),
          Text(
            selectedFilm.homepage ?? "",
          ),
          Text(
            selectedFilm.overview ?? "",
          ),
          Text(
            "Rating: ${selectedFilm.voteAverage}/10 ${selectedFilm.voteCount} votes",
          ),
        ],
      ),
    );
  }
}
