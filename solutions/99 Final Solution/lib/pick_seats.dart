// import 'package:daam/state/app_state.dart';
// import 'package:daam/state/superState.dart';
import 'dart:math';

import 'package:daam/state/global.dart';
import 'package:daam/state/showing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    var random = Random().nextInt(1000);
    assert(selectedShowing.theaterId == theater["id"],
        "Theater is out of sync. That should never happen.");
    return Scaffold(
        appBar: AppBar(
          title: Text("Pick your seats $random"),
        ),
        body: InteractiveViewer(
          minScale: 0.2,
          maxScale: 10.0,
          clipBehavior: Clip.none,
          child: SizedBox(
            width: 700.0,
            child: LayoutBuilder(builder: (context, constraints) {
              print(
                  "maxWidth: ${constraints.maxWidth}, maxHeight: ${constraints.maxHeight}");
              return SeatMap(theater: theater);
            }),
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

class SeatMap extends StatelessWidget {
  const SeatMap({
    super.key,
    required this.theater,
  });

  final Map<String, dynamic> theater;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: theater["tables"]
          .map<Widget>((table) => daam_table.Table(table: table))
          .toList(),
    );
  }
}
