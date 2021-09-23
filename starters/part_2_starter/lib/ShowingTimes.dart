import 'package:daam/Film.dart';
import 'package:daam/state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowingTimes extends StatefulWidget {
  final Film film;
  final DateTime selected_date;
  final List<dynamic> showings;
  const ShowingTimes(
      {required this.film, required this.selected_date, required this.showings})
      : super();

  @override
  _ShowingTimesState createState() => _ShowingTimesState();
}

class _ShowingTimesState extends State<ShowingTimes> {
  @override
  @override
  Widget build(BuildContext context) {
    String selectedDateString =
        new DateFormat.MMMMEEEEd().format(widget.selected_date);
    return Column(
      children: [
        Text("Showing times for $selectedDateString for ${widget.film.title}"),
        Column(
          children: _makeShowingWidgets(widget.showings),
        ),
      ],
    );
  }

  List<Widget> _makeShowingWidgets(showings) {
    List<Widget> textWidgets = <Widget>[];
    for (int i = 0; i < showings.length; i++) {
      DateTime showingTime = DateTime.parse(showings[i]['showing_time']);
      String timeString = new DateFormat.jm().format(showingTime.toLocal());
      var textWidget = TextButton(
        child: Text(timeString),
        onPressed: () {
          // TODO 2: Save the showing in state.
          // TODO 1: Navigate to PickSeats
          Navigator.pushNamed(context, '/pickseats');
        },
      );
      textWidgets.add(textWidget);
    }
    return textWidgets;
  }
}
