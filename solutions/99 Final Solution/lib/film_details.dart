import 'package:daam/state/app_state.dart';
import 'package:flutter/material.dart';
import 'state.dart';
import 'showing_times.dart';
import 'state/superState.dart';

class FilmDetails extends StatefulWidget {
  const FilmDetails({Key? key}) : super(key: key);

  @override
  State<FilmDetails> createState() => _FilmDetailsState();
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
            (_state.selectedFilm == null ||
                    _state.selectedFilm!.posterPath!.isEmpty)
                ? Container()
                : Image.network(
                    "http://localhost:3008/${_state.selectedFilm!.posterPath}"),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: ShowingTimes(
                    film: _state.selectedFilm!,
                    selectedDate: _state.selectedDate,
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(_state.selectedFilm?.title ?? "")),
                Container(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(_state.selectedFilm?.tagline ?? "")),
                Container(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(_state.selectedFilm?.homepage ?? "")),
                Container(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(_state.selectedFilm?.overview ?? "")),
                Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                      "Rating: ${_state.selectedFilm?.voteAverage}/10 ${_state.selectedFilm?.voteCount} votes"),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
