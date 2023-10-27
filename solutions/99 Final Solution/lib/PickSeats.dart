import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'state.dart';
import 'providers/selectedShowingProvider.dart';
import 'providers/reservationsProvider.dart';
import 'state/Film.dart';
import 'state/Showing.dart';
import 'Table.dart' as daamTable;

class PickSeats extends ConsumerStatefulWidget {
  const PickSeats({Key? key}) : super(key: key);

  @override
  _PickSeatsState createState() => _PickSeatsState();
}

class _PickSeatsState extends ConsumerState<PickSeats> {
  var _film = Film();
  Map<String, dynamic> _theater = {};
  Showing? _selected_showing;
  List<Map<String, dynamic>> _reservations = [];
  var selected_date = DateTime.now();
  List<Map<String, dynamic>> _cart = [];
  @override
  void initState() {
    super.initState();
    // Get the selected showing from state
    _selected_showing = ref.read(selectedShowingProvider);
    assert(_selected_showing != null,
        "When picking seats, the showing is null. This should never happen!");
    // Ask the API server for all of the tables and seats for this theater.
    fetchTheater(theater_id: _selected_showing!.theaterId).then((theater) =>
        setState(() => ref.read(theaterProvider.notifier).set(theater)));
    // Ask the API server for all the reservations for this showing.
    fetchReservationsForShowing(showing_id: _selected_showing!.id).then((res) {
      var reservations = (res as List).cast<Map<String, dynamic>>();
      ref.read(reservationsProvider.notifier).set(reservations);
      setState(() => _reservations = reservations);
    });
  }

  @override
  Widget build(BuildContext context) {
    _cart = ref.watch(cartProvider);
    print("cart is $_cart");
    _film = ref.read(selectedFilmProvider) ?? Film()
      ..id = _selected_showing!.filmId;
    _reservations = ref.read(reservationsProvider);
    _theater = ref.read(theaterProvider) ?? {"tables": []};

    print(_reservations);
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
              children: _theater["tables"]
                  .map<Widget>((table) => daamTable.Table(table: table))
                  .toList(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.shopping_cart),
          // We're going to eventually need to put showing and table in the cart
          onPressed: () {
            _cart.add({"table_number": 10, "seat_number": 1, "price": 10.75});
            _cart.add({"table_number": 10, "seat_number": 2, "price": 10.75});
            _cart.add({"table_number": 10, "seat_number": 3, "price": 10.75});
            _cart.add({"table_number": 10, "seat_number": 4, "price": 10.75});
            ref.read(cartProvider.notifier).set(_cart);
            Navigator.pushNamed(context, '/checkout');
          },
        ));
  }
}
