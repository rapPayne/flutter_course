import 'package:daam/state/global.dart';
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
  Map<String, dynamic> cart = global.get<Map<String, dynamic>>("cart");

  @override
  void initState() {
    super.initState();
    loadShowings();
  }

  @override
  void didUpdateWidget(oldWidget) {
    if (widget.selectedDate.day != oldWidget.selectedDate.day) {
      loadShowings();
    }
    super.didUpdateWidget(oldWidget);
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
            children: _showings.map((s) => _makeShowingWidget(s)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _makeShowingWidget(dynamic showing) {
    DateTime showingTime = DateTime.parse(showing["showing_time"]);
    String timeString = DateFormat.jm().format(showingTime.toLocal());
    return TextButton(
      onPressed: () => chooseShowing(showing),
      child: Text(
        timeString,
      ),
    );
  }

  void loadShowings() {
    fetchShowings(filmId: widget.film.id, date: widget.selectedDate)
        .then((showings) => setState(() => _showings = showings));
  }

  void chooseShowing(dynamic showing) {
    // Ask the API server for all of the tables and seats for this theater
    var theaterFuture = fetchTheater(theaterId: showing['theater_id']);
    // Ask the API server for all reservations for this showing
    var reservationsFuture =
        fetchReservationsForShowing(showingId: showing['id'])
            .then((reservations) => reservations as List)
            .then((reservations) => reservations.cast<Map<String, dynamic>>());
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
      global.set("theater", theater);
      global.set("selectedShowing", showing);

      Navigator.pushNamed(context, '/pickseats');
    });
  }
}

enum SeatStatus {
  available, // Duh
  inCart, // Available, but you have it in your cart
  reserved // Somebody else has this seat reserved
}

/// Returns a seat's status
///
/// seat: The seat whose status we're examining
/// reservations: All the reservations from other customers. These are unavailable
/// cart: The current shopping cart. You may already have this seat in your cart.
SeatStatus getSeatStatus(Map seat, List<Map<String, dynamic>> reservations,
    Map<String, dynamic> cart) {
  bool seatIsInCart = cart['seats'].any((heldSeat) => heldSeat == seat['id']);
  if (seatIsInCart) {
    return SeatStatus.inCart;
  }
  bool seatIsReserved =
      reservations.any((reservation) => reservation['seat_id'] == seat['id']);
  if (seatIsReserved) return SeatStatus.reserved;
  return SeatStatus.available;
}
