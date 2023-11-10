import 'package:daam/state/AppState.dart';
import 'package:flutter/material.dart';
import 'state.dart';
import 'showing_times.dart';
import 'state/SuperState.dart';

class FilmDetails extends StatefulWidget {
  const FilmDetails({Key? key}) : super(key: key);

  @override
  _FilmDetailsState createState() => _FilmDetailsState();
}

class _FilmDetailsState extends State<FilmDetails> {
  late AppState _state;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _state = SuperState.of(context).state;

    // Get the entire file from the film ID
    // Read the currently selected film ID from state.
    assert(_state.selectedFilm?.id != null,
        "Selected film ID should never be null at this point");
    fetchFilm(id: _state.selectedFilm!.id)
        .then((f) => setState(() => _state.selectedFilm = f));
  }

  @override
  Widget build(BuildContext context) {
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
            Image.network("http://localhost:3008/" +
                (_state.selectedFilm!.poster_path ?? "")),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: ShowingTimes(
                    film: _state.selectedFilm!,
                    selected_date: _state.selectedDate,
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(_state.selectedFilm?.title ?? "")),
                Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(_state.selectedFilm?.tagline ?? "")),
                Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(_state.selectedFilm?.homepage ?? "")),
                Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(_state.selectedFilm?.overview ?? "")),
                Container(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                      "Rating: ${_state.selectedFilm?.vote_average}/10 ${_state.selectedFilm?.vote_count} votes"),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
