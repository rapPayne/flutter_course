import 'package:daam/state/AppState.dart';
import 'package:daam/state/SuperState.dart';
import 'package:flutter/material.dart';
import 'state.dart';
import 'state/Showing.dart';
import 'state/Repository.dart';
import 'table.dart' as daamTable;
import 'state/Seat.dart';

class PickSeats extends StatefulWidget {
  const PickSeats({Key? key}) : super(key: key);

  @override
  _PickSeatsState createState() => _PickSeatsState();
}

class _PickSeatsState extends State<PickSeats> {
  late List<Map<String, dynamic>> _cart;
  Showing? _selectedShowing;
  //List<Map<String, dynamic>> _reservations = [];
  var selected_date = DateTime.now();
  late SuperState _ss;

  @override
  void didChangeDependencies() {
    _ss = SuperState.of(context);
    _selectedShowing = _ss.state.selectedShowing;
    assert(_selectedShowing != null,
        "When picking seats, the selected showing is null. This should never happen!");
    _cart = _ss.state.cart;
    // Ask the API server for all of the tables and seats for this theater.
    fetchTheater(theater_id: _selectedShowing!.theaterId).then((theater) {
      fetchReservationsForShowing(showing_id: _selectedShowing!.id).then((res) {
        var reservations = (res as List).cast<Map<String, dynamic>>();
        for (var table in theater['tables']) {
          for (var seat in table['seats']) {
            seat["status"] = getSeatStatus(seat, reservations, _cart);
          }
        }
        AppState newState = _ss.state;
        newState.theater = theater;
        newState.reservations = reservations;
        _ss.setState(newState);
      });

      //setState(() => _theater = theater);
    });
    // Ask the API server for all the reservations for this showing.
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("cart is $_cart");
    //print("theater is ${_theater}");
    // _film = _selectedShowing?.film ?? Film()
    //   ..id = _selectedShowing!.filmId;

    return Scaffold(
        appBar: AppBar(
          title: Text("Pick your seats"),
        ),
        body: InteractiveViewer(
          child: Container(
            width: 1000.0,
            height: 1000.0,
            padding: EdgeInsets.all(10.0),
            child: Stack(
              alignment: Alignment.topLeft,
              children: (_ss.state.theater ?? {"tables": []})["tables"]
                  .map<Widget>((table) => daamTable.Table(table: table))
                  .toList(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.shopping_cart),
          // We're going to eventually need to put showing and table in the cart
          onPressed: () {
            // _state.cart
            //     ?.add({"table_number": 10, "seat_number": 1, "price": 10.75});
            // _state.cart
            //     ?.add({"table_number": 10, "seat_number": 2, "price": 10.75});
            // _state.cart
            //     ?.add({"table_number": 10, "seat_number": 3, "price": 10.75});
            // _state.cart
            //     ?.add({"table_number": 10, "seat_number": 4, "price": 10.75});

            Navigator.pushNamed(context, '/checkout');
          },
        ));
  }

  SeatStatus getSeatStatus(Map seat, List<Map<String, dynamic>> reservations,
      List<Map<String, dynamic>> cart) {
    bool seatIsReserved =
        reservations.any((reservation) => reservation['seat_id'] == seat['id']);
    if (seatIsReserved) return SeatStatus.reserved;
    bool seatIsInCart =
        cart.any((heldSeat) => heldSeat['seat_id'] == seat['id']);
    if (seatIsInCart) return SeatStatus.inCart;
    return SeatStatus.available;
  }
}
