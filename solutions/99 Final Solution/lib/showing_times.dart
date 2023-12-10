import 'package:daam/state.dart';
import 'package:daam/state/global.dart';
import 'package:daam/state/movie.dart';
import 'package:daam/state/repository.dart';
import 'state/showing.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'state/seat.dart';

class ShowingTimes extends StatefulWidget {
  final Movie film;
  final DateTime selectedDate;
  const ShowingTimes(
      {super.key, required this.film, required this.selectedDate});

  @override
  State<ShowingTimes> createState() => _ShowingTimesState();
}

class _ShowingTimesState extends State<ShowingTimes> {
  List<Showing> _showings = [];

  @override
  void initState() {
    fetchShowings(filmId: widget.film.id, date: widget.selectedDate).then((s) {
      setState(() {
        _showings = s;
      });
    });
    super.initState();
  }

  List<Map<String, dynamic>> cart =
      global.get<List<Map<String, dynamic>>>("cart");

  @override
  Widget build(BuildContext context) {
    //_state = SuperState.of(context).stateWrapper.state as AppState;
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
      var textButton = TextButton(
        child: Text(timeString),
        onPressed: () async {
          // Ask the API server for all of the tables and seats for this theater.
          var theater = await fetchTheater(theaterId: showings[i].theaterId);
          var reservations =
              (await fetchReservationsForShowing(showingId: showings[i].id)
                      as List)
                  .cast<Map<String, dynamic>>();
          for (var table in theater['tables']) {
            for (var seat in table['seats']) {
              seat['table_number'] = table['table_number'];
              seat['status'] = getSeatStatus(seat, reservations, cart);
            }
          }
          global.set("theater", theater);
          global.set("selectedShowing", showings[i]);
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, '/pickseats');
        },
      );
      textWidgets.add(textButton);
    }
    return textWidgets;
  }
}

SeatStatus getSeatStatus(Map seat, List<Map<String, dynamic>> reservations,
    List<Map<String, dynamic>> cart) {
  bool seatIsInCart = cart.any((heldSeat) => heldSeat['id'] == seat['id']);
  if (seatIsInCart) {
    print("found a seat in the cart");
    return SeatStatus.inCart;
  }
  bool seatIsReserved =
      reservations.any((reservation) => reservation['seat_id'] == seat['id']);
  if (seatIsReserved) return SeatStatus.reserved;
  return SeatStatus.available;
}
