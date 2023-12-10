// import 'package:daam/state/app_state.dart';
// import 'package:daam/state/superState.dart';
import 'package:daam/state/global.dart';
import 'package:daam/state/showing.dart';
import 'package:flutter/material.dart';
import 'table.dart' as daam_table;

class PickSeats extends StatefulWidget {
  const PickSeats({super.key});

  @override
  State<PickSeats> createState() => _PickSeatsState();
}

class _PickSeatsState extends State<PickSeats> {
  // late AppState _state;
  DateTime selectedDate = global.get<DateTime>("selectedDate");
  Showing selectedShowing = global.get<Showing>("selectedShowing");
  Map<String, dynamic> theater = global.get<Map<String, dynamic>>("theater");

  // @override
  // void didChangeDependencies() {
  //   _state = SuperState.of(context).stateWrapper.state as AppState;
  //   assert(_state.theater != null,
  //       "When picking seats, the theater is null. This should never happen!");
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    assert(selectedShowing.theaterId == theater["id"],
        "Theater is out of sync. That should never happen.");
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
              children: theater["tables"]
                  .map<Widget>((table) => daam_table.Table(table: table))
                  .toList(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.pushNamed(context, '/checkout');
          },
        ));
  }
}
