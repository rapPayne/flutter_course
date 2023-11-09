import 'package:daam/state/SuperState.dart';
import 'package:flutter/material.dart';
import 'state.dart';
import 'state/Film.dart';
import 'DatePicker.dart';
import 'FilmBrief.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  List<Film>? films;
  late SuperState _ss;

  @override
  void initState() {
    fetchFilms().then((f) => setState(() => films = f));
    //TODO: Write these films to SuperState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // Get state
    _ss = SuperState.of(context);
    _ss.addListener(() {
      setState(() {});
    });
    // TODO: may not be needed?
    print("Landing changed dependencies");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            children: [
              Image.asset("assets/daam.png", height: 75, fit: BoxFit.cover),
              Text("Dinner And A Movie"),
            ],
          ),
          Text(
              "Tap a movie below to see its details. Then pick a date to see showtimes."),
          DatePicker(),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: films == null
                  ? []
                  : films!
                      .map((f) => FilmBrief(
                            film: f,
                          ))
                      .toList(),
            ),
          ),
        ]),
      ),
    );
  }
}
