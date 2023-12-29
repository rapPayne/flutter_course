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
  List<Map<String, dynamic>> cart =
      global.get<List<Map<String, dynamic>>>("cart");

  @override
  void initState() {
    fetchShowings(filmId: widget.film.id, date: widget.selectedDate).then((s) {
      setState(() {
        _showings = s;
      });
    });
    super.initState();
  }

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
        onPressed: () {
          // Ask the API server for all of the tables and seats for this theater
          var theaterFuture = fetchTheater(theaterId: showings[i].theaterId);
          // Ask the API server for all reservations for this showing
          var reservationsFuture = fetchReservationsForShowing(
                  showingId: showings[i].id)
              .then((reservations) => (reservations as List))
              .then(
                  (reservations) => reservations.cast<Map<String, dynamic>>());
          // After the server fully responds, mark each seat as available, inCart, or reserved
          Future.wait([theaterFuture, reservationsFuture]).then((fa) {
            var theater = fa[0] as Map<String, dynamic>;
            var reservations = fa[1] as List<Map<String, dynamic>>;
            for (var table in theater['tables']) {
              for (var seat in table['seats']) {
                seat['table_number'] = table['table_number'];
                seat['status'] = getSeatStatus(seat, reservations, cart);
              }
            }
            //TODO: Set the theater in Global state here
            //TODO: Set the selectedShowing in Global state here
            global.set("theater", theater);
            global.set("selectedShowing", showings[i]);
            Navigator.pushNamed(context, '/pickseats');
          });
        },
      );
      textWidgets.add(textButton);
    }
    return textWidgets;
  }
}

/// Returns a seat's status
///
/// seat: The seat whose status we're examining
/// reservations: All the reservations from other customers. These seats are unavailable
/// cart: The current shopping cart. You may already have this seat in your cart.
SeatStatus getSeatStatus(Map seat, List<Map<String, dynamic>> reservations,
    List<Map<String, dynamic>> cart) {
  bool seatIsInCart = cart.any((heldSeat) => heldSeat['id'] == seat['id']);
  if (seatIsInCart) {
    return SeatStatus.inCart;
  }
  bool seatIsReserved =
      reservations.any((reservation) => reservation['seat_id'] == seat['id']);
  if (seatIsReserved) return SeatStatus.reserved;
  return SeatStatus.available;
}
