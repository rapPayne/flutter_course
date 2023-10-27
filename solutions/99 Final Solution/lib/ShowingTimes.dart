import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:daam/state/Film.dart';
import 'state/Showing.dart';
import 'package:daam/state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'providers/showingsProvider.dart';
import 'providers/selectedShowingProvider.dart';

class ShowingTimes extends ConsumerStatefulWidget {
  final Film film;
  final DateTime selected_date;
  const ShowingTimes({required this.film, required this.selected_date})
      : super();

  @override
  _ShowingTimesState createState() => _ShowingTimesState();
}

class _ShowingTimesState extends ConsumerState<ShowingTimes> {
  List<Showing> _showings = [];

  @override
  void initState() {
    fetchShowings(film_id: widget.film.id, date: widget.selected_date)
        .then((s) {
      setState(() {
        _showings = s;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //List<dynamic> showings = ref.read(showingsProvider);
    String selectedDateString =
        new DateFormat.MMMMEEEEd().format(widget.selected_date);

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
      String timeString = new DateFormat.jm().format(showingTime.toLocal());
      var textWidget = TextButton(
        child: Text(timeString),
        onPressed: () {
          print('Pressed $timeString');
          // TODO: Save the showing in state.
          ref.read(selectedShowingProvider.notifier).set(showings[i]);
          Navigator.pushNamed(context, '/pickseats');
        },
      );
      textWidgets.add(textWidget);
    }
    return textWidgets;
  }
}
