import 'package:daam/state/app_state.dart';
import 'package:daam/state/Film.dart';
import 'package:daam/state/repository.dart';
import 'package:daam/state/superState.dart';
import 'state/showing.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowingTimes extends StatefulWidget {
  final Film film;
  final DateTime selectedDate;
  const ShowingTimes({Key? key, required this.film, required this.selectedDate})
      : super(key: key);

  @override
  State<ShowingTimes> createState() => _ShowingTimesState();
}

class _ShowingTimesState extends State<ShowingTimes> {
  List<Showing> _showings = [];
  late SuperState _ss;

  @override
  void didChangeDependencies() {
    _ss = SuperState.of(context);
    //TODO: RAP, should this be in initState()? If initState() runs when
    // this is re-rendered, then yes b/c the film_id and date will be
    // different each time.
    fetchShowings(filmId: widget.film.id, date: widget.selectedDate).then((s) {
      setState(() {
        _showings = s;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String selectedDateString =
        DateFormat.MMMMEEEEd().format(widget.selectedDate);

    // This is the one causing the problem. When I Flex the row, it gets
    // infinite height. So Column needs to be constrained.
    return Column(
      mainAxisSize: MainAxisSize.min, // <- Added MainAxisSize.min
      children: [
        Text("Showing times for $selectedDateString for ${widget.film.title}"),
        Flexible(
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            runAlignment: WrapAlignment.center,
            children: _makeShowingWidgets(_showings),
          ),
        ),
      ],
    );
  }

  List<Widget> _makeShowingWidgets(List<Showing> showings) {
    List<Widget> textWidgets = <Widget>[];
    for (int i = 0; i < showings.length; i++) {
      DateTime showingTime = showings[i].showingTime;
      String timeString = DateFormat.jm().format(showingTime.toLocal());
      var textWidget = TextButton(
        child: Text(timeString),
        onPressed: () {
          AppState newState = _ss.state;
          newState.selectedShowing = showings[i];
          _ss.setState(newState);
          Navigator.pushNamed(context, '/pickseats');
        },
      );
      textWidgets.add(textWidget);
    }
    return textWidgets;
  }
}
