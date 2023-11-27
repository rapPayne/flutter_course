import 'package:daam/state/app_state.dart';
import 'package:daam/state/superState.dart';
import 'package:flutter/material.dart';
import 'state.dart';
import 'state/showing.dart';
import 'state/repository.dart';
import 'table.dart' as daam_table;
import 'state/seat.dart';

class PickSeats extends StatefulWidget {
  const PickSeats({super.key});

  @override
  State<PickSeats> createState() => _PickSeatsState();
}

class _PickSeatsState extends State<PickSeats> {
  late AppState _state;
  late List<Map<String, dynamic>> _cart;
  Showing? _selectedShowing;
  //List<Map<String, dynamic>> _reservations = [];
  var selectedDate = DateTime.now();

  @override
  void didChangeDependencies() {
    _state = SuperState.of(context).stateWrapper.state as AppState;
    _selectedShowing = _state.selectedShowing;
    assert(_selectedShowing != null,
        "When picking seats, the selected showing is null. This should never happen!");
    _cart = _state.cart;
    // Ask the API server for all of the tables and seats for this theater.
    fetchTheater(theaterId: _selectedShowing!.theaterId).then((theater) {
      fetchReservationsForShowing(showingId: _selectedShowing!.id).then((res) {
        var reservations = (res as List).cast<Map<String, dynamic>>();
        for (var table in theater['tables']) {
          for (var seat in table['seats']) {
            seat["status"] = getSeatStatus(seat, reservations, _cart);
          }
        }
      });
      SuperState.of(context).change(_state.copyWith(theater: theater));
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pick your seats"),
        ),
        body: InteractiveViewer(
          child: Container(
            width: 1000.0,
            height: 1000.0,
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              alignment: Alignment.topLeft,
              children: (_state.theater ?? {"tables": []})["tables"]
                  .map<Widget>((table) => daam_table.Table(table: table))
                  .toList(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.shopping_cart),
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
