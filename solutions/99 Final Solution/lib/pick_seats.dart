import 'dart:math';
import 'package:raw_state/raw_state.dart';
import 'package:flutter/material.dart';
import 'table.dart' as daam_table;

class PickSeats extends StatefulWidget {
  const PickSeats({super.key});

  @override
  State<PickSeats> createState() => _PickSeatsState();
}

class _PickSeatsState extends State<PickSeats> {
  DateTime selectedDate = rawState.get<DateTime>("selectedDate");
  Map<String, dynamic> selectedShowing =
      rawState.get<Map<String, dynamic>>("selectedShowing");
  Map<String, dynamic> cart = rawState.get<Map<String, dynamic>>("cart");
  Map<String, dynamic> theater = rawState.get<Map<String, dynamic>>("theater");

  @override
  Widget build(BuildContext context) {
    var random = Random().nextInt(1000);
    assert(selectedShowing["theater_id"] == theater["id"],
        "Theater is out of sync. That should never happen.");
    return Scaffold(
        appBar: AppBar(
          title: Text("Pick your seats $random"),
        ),
        body: SingleChildScrollView(
          child: InteractiveViewer(
            // minScale: 0.2,
            // maxScale: 10.0,
            //clipBehavior: Clip.none,
            child:
                // LayoutBuilder(builder: (context, constraints) {
                //   print(
                //       "maxWidth: ${constraints.maxWidth}, maxHeight: ${constraints.maxHeight}");
                //   return
                Transform.scale(
              scale: 0.95,
              //origin: const Offset(1.0, 1.0),
              child: theaterWidget(theater: theater),
            ),
            // }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.shopping_cart),
          onPressed: () {
            //TODO: Save the cart to global?
            Navigator.pushNamed(context, '/checkout');
          },
        ));
  }

  Widget theaterWidget({Map<String, dynamic> theater = const {}}) {
    var widget = Container(
      width: 2500,
      height: 500,
      clipBehavior: Clip.none,
      child: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              "Screen",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Colors.white),
            ),
          ),
          SeatMap(
            theater: theater,
          ),
        ],
      ),
      // Row(
      //   children: [
      //     aBox(),
      //     aBox(color: Colors.green),
      //     aBox(color: Colors.blue),
      //   ],
      // ),
    );
    return widget;
  }
}

// Widget aBox({
//   double width = 333.3,
//   Color color = Colors.red,
// }) {
//   return Container(
//     width: width,
//     color: color,
//   );
// }

class SeatMap extends StatelessWidget {
  const SeatMap({
    super.key,
    required this.theater,
  });

  final Map<String, dynamic> theater;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3500.0,
      height: 450.0,
      clipBehavior: Clip.none, // This does nothing.
      child: Stack(
        alignment: Alignment.topLeft,
        children: theater["tables"]
            .map<Widget>((table) => daam_table.Table(table: table))
            .toList(),
      ),
    );
  }
}
