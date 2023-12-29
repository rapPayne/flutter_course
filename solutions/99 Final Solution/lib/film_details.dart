import 'package:daam/state/global.dart';
import 'package:daam/state/movie.dart';
import 'package:flutter/material.dart';
import 'showing_times.dart';

class FilmDetails extends StatelessWidget {
  const FilmDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Movie selectedFilm = global.get<Movie>("selectedFilm");
    DateTime selectedDate = global.get<DateTime>("selectedDate");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Film Details"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
            child: Flex(
          direction: MediaQuery.of(context).orientation == Orientation.portrait
              ? Axis.vertical
              : Axis.horizontal,
          children: [
            (selectedFilm.posterPath!.isEmpty)
                ? Container()
                : Image.network(
                    "http://localhost:3008/${selectedFilm.posterPath}"),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ShowingTimes(
                    film: selectedFilm,
                    selectedDate: selectedDate,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    selectedFilm.title ?? "",
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    selectedFilm.tagline ?? "",
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    selectedFilm.homepage ?? "",
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    selectedFilm.overview ?? "",
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    "Rating: ${selectedFilm.voteAverage}/10 ${selectedFilm.voteCount} votes",
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
