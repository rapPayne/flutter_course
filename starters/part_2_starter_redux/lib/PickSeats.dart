import 'package:flutter/material.dart';
import 'Table.dart' as daamTable;
import 'Film.dart';
import 'store/store.dart';
import 'store/Actions.dart' as daam_Actions;

class PickSeats extends StatefulWidget {
  const PickSeats({Key? key}) : super(key: key);

  @override
  _PickSeatsState createState() => _PickSeatsState();
}

class _PickSeatsState extends State<PickSeats> {
  var _film = Film();
  var _theater = {};
  var _selected_showing = {};
  var _reservations = [];
  var _selected_date = DateTime.now();
  List<Map<String, dynamic>> _cart = [];
  @override
  void initState() {
    super.initState();
    // Get the selected showing from state
    // _selected_showing = context.read(selectedShowingProvider).state;
    _selected_showing = store.state.selectedShowing;
    // Ask the API server for all of the tables and seats for this theater.
    // fetchTheater(theater_id: _selected_showing["theater_id"])
    //     .then((theater) => setState(() => _theater = theater));
    store.dispatch({
      'type': daam_Actions.Actions.FETCH_THEATER,
      'theater_id': _selected_showing["theater_id"]
    });
    // Ask the API server for all the reservations for this showing.
    // fetchReservationsForShowing(showing_id: _selected_showing["id"])
    //     .then((reservations) => setState(() => _reservations = reservations));
  }

  @override
  Widget build(BuildContext context) {
    //_film = context.read(selectedFilmProvider).state ?? Film();
    _film = store.state.selectedFilm ?? Film();
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick your seats"),
      ),
      body: Column(
        children: [
          Text("PickSeats"),
          daamTable.Table(), // <-- Note the "daamTable" prefix
          FloatingActionButton(
            child: Icon(Icons.shopping_cart),
            onPressed: () {
              // Fake putting four seats in the cart.
              _cart.add({"table_number": 10, "seat_number": 1, "price": 10.75});
              _cart.add({"table_number": 10, "seat_number": 2, "price": 10.75});
              _cart.add({"table_number": 10, "seat_number": 3, "price": 10.75});
              _cart.add({"table_number": 10, "seat_number": 4, "price": 10.75});
              // What goes here? Saving the _cart to the cartProvider.
              print('context.read(cartProvider).state = _cart');
              Navigator.pushNamed(context, '/checkout');
            },
          ),
        ],
      ),
    );
  }
}
