import 'package:daam/state/repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:daam/state/film.dart';

class ShowingTimes extends StatefulWidget {
  final Film film;
  final DateTime selectedDate;
  const ShowingTimes(
      {super.key, required this.film, required this.selectedDate});

  @override
  State<ShowingTimes> createState() => _ShowingTimesState();
}

class _ShowingTimesState extends State<ShowingTimes> {
  List<dynamic> _showings = [];

  @override
  void initState() {
    fetchShowings(filmId: widget.film.id, date: widget.selectedDate)
        .then((showings) => setState(() => _showings = showings));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String selectedDateString =
        DateFormat.MMMMEEEEd().format(widget.selectedDate);
    return Column(
      children: [
        Text("Showing times for $selectedDateString for ${widget.film.title}"),
        // ignore: avoid_unnecessary_containers
        Container(
          child: Column(
            children: _showings
                .map((s) => makeTextWidget(s["showing_time"]))
                .toList(),
          ),
        ),
      ],
    );
  }

  Text makeTextWidget(dynamic dateString) {
    DateTime showingTime = DateTime.parse(dateString);
    String timeString = DateFormat.jm().format(showingTime.toLocal());
    return Text(timeString);
  }
}
