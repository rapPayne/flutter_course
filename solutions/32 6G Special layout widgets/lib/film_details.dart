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
    bool isPortrait = MediaQuery.orientationOf(context) == Orientation.portrait;
    bool isLandscape = !isPortrait;
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedFilm.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Flex(
          mainAxisSize: MainAxisSize.min,
          direction: isPortrait ? Axis.vertical : Axis.horizontal,
          children: [
            Image.network(
              "http://localhost:3008/${selectedFilm.posterPath}",
              fit: BoxFit.cover,
              height:
                  isLandscape ? MediaQuery.sizeOf(context).height * 0.8 : null,
              width: isPortrait ? 300.0 : null,
            ),
            Flexible(
              child: Column(
                children: [
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
            ),
          ],
        ),
      ),
    );
  }
}
