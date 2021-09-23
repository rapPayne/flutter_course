import 'package:flutter/material.dart';
//import 'deleteme_state.dart.temp';
import 'Film.dart';
import 'ShowingTimes.dart';
import 'store/store.dart';
import 'store/Actions.dart' as daam_Actions;

class FilmDetails extends StatefulWidget {
  const FilmDetails({Key? key}) : super(key: key);

  @override
  _FilmDetailsState createState() => _FilmDetailsState();
}

class _FilmDetailsState extends State<FilmDetails> {
  Film film = Film()..poster_path = "1.jpg";
  DateTime selected_date = DateTime.now();
  List<dynamic> showings = [];

  @override
  void initState() {
    super.initState();
    // Read the currently selected film from state. If there isn't one, use film id of 1.
    //film = context.read(selectedFilmProvider).state ?? Film()..id = 1;
    film = store.state.selectedFilm ?? Film()
      ..id = 1;
    // Read the currently selected date. Use today if no date has been selected yet.
    //selected_date = context.read(selectedDateProvider).state ?? DateTime.now();
    selected_date = store.state.selectedDate ?? DateTime.now();
    // fetchFilm(id: 1).then((f) => setState(() {
    //       context.read(selectedFilmProvider).state = f;
    //     }));
    // Ask the API server for all of the showings for the selected film and date.
    // fetchShowings(film_id: film.id, date: selected_date)
    //     .then((s) => setState(() => context.read(showingsProvider).state = s));
    store.dispatch({
      'type': daam_Actions.Actions.FETCH_SHOWINGS,
      'film_id': film.id,
      'date': selected_date
    });
  }

  @override
  Widget build(BuildContext context) {
    //film = context.read(selectedFilmProvider).state ?? Film();
    film = store.state.selectedFilm ?? Film();
    //showings = context.read(showingsProvider).state;
    showings = store.state.showings;
    return Scaffold(
      appBar: AppBar(
        title: Text("Film details"),
      ),
      body: SingleChildScrollView(
          child: Flex(
        direction: MediaQuery.of(context).orientation == Orientation.landscape
            ? Axis.horizontal
            : Axis.vertical,
        children: [
          Image.network("${getBaseUrl()}/" + (film.poster_path ?? "")),
          Column(
            children: [
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
          ),
        ],
      )),
    );
  }
}
