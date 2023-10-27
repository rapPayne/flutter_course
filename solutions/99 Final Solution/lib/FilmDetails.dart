import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state.dart';
import 'state/Film.dart';
import 'ShowingTimes.dart';
import 'providers/showingsProvider.dart';

class FilmDetails extends ConsumerStatefulWidget {
  const FilmDetails({Key? key}) : super(key: key);

  @override
  _FilmDetailsState createState() => _FilmDetailsState();
}

class _FilmDetailsState extends ConsumerState<FilmDetails> {
  Film _film = Film();
  DateTime selected_date = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Read the currently selected film from state.
    _film = ref.read(selectedFilmProvider) ?? Film();
    // Read the currently selected date. Use today if no date has been selected yet.
    selected_date =
        ref.read(selectedDateProvider) ?? DateTime.now().add(Duration(days: 2));
    fetchFilm(id: _film.id).then((f) => setState(() {
          ref.read(selectedFilmProvider.notifier).set(f);
        }));
  }

  @override
  Widget build(BuildContext context) {
    _film = ref.read(selectedFilmProvider) ?? Film();
    return Scaffold(
      appBar: AppBar(
        title: Text("Film Details"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
            child: Flex(
          direction: MediaQuery.of(context).orientation == Orientation.portrait
              ? Axis.vertical
              : Axis.horizontal,
          children: [
            Image.network("http://localhost:3008/" + (_film.poster_path ?? "")),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ShowingTimes(
                    film: _film,
                    selected_date: selected_date,
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(_film.title ?? "")),
                Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(_film.tagline ?? "")),
                Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(_film.homepage ?? "")),
                Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(_film.overview ?? "")),
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                      "Rating: ${_film.vote_average}/10 ${_film.vote_count} votes"),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
