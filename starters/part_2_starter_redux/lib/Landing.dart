import 'package:flutter/material.dart';
import 'Film.dart';
import 'DatePicker.dart';
import 'FilmBrief.dart';
import 'store/store.dart';
import 'store/Actions.dart' as daam_Actions;

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  // Film film = Film()
  //   ..id = 0
  //   ..homepage = "http://hardcoded.film"
  //   ..overview = "I'm putting all of this in a string"
  //   ..popularity = 5
  //   ..poster_path = "/img/posters/2.jpg"
  //   ..release_date = DateTime.now()
  //   ..runtime = 94
  //   ..title = "Hardcoded Movie Title"
  //   ..tagline = "A hardcoded movie"
  //   ..popularity = 7.4
  //   ..vote_average = 1.3
  //   ..vote_count = 822;
  @override
  Widget build(BuildContext context) {
    //List<Film> films = context.read(filmsProvider).state;
    List<Film> films = store.state.films;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(children: [
          Image.asset("assets/daam.png", height: 75, fit: BoxFit.cover),
          Text("Dinner And A Movie"),
          Text(
              "Tap a movie below to see its details. Then pick a date to see showtimes."),
          DatePicker(),
          Column(
            children: films
                .map((f) => FilmBrief(
                      film: f,
                    ))
                .toList(),
          ),
        ])),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //fetchFilms().then((films) => context.read(filmsProvider).state = films);
    store.dispatch({'type': daam_Actions.Actions.FETCH_FILMS});
  }
}
