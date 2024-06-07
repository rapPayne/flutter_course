import 'dart:math';
import 'package:flutter/widgets.dart';
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
    var screenSize = MediaQuery.sizeOf(context);
    print("Screen size: $screenSize");

    var appBarSize = AppBar().preferredSize;
    var usableHeight = screenSize.height - appBarSize.height;
    var usableWidth = 0.8 * screenSize.width;
    print("$usableWidth, $usableHeight");
    assert(selectedShowing["theater_id"] == theater["id"],
        "Theater is out of sync. That should never happen.");
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pick your seats"),
        ),
        body: InteractiveViewer(
          // minScale: 0.2,
          // maxScale: 10.0,
          //clipBehavior: Clip.none,
          constrained: false,
          child:
              // LayoutBuilder(builder: (context, constraints) {
              //   print(
              //       "maxWidth: ${constraints.maxWidth}, maxHeight: ${constraints.maxHeight}");
              //   return
              //theaterWidget(theater: theater),
              SeatMap(
                  theater: theater, width: usableWidth, height: usableHeight),
          //aBox(width: usableWidth, height: usableHeight)
          // }),
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
      // width: 2500,
      // height: 500,
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

Widget aBox({
  double width = 333.3,
  double height = 100.0,
  Color color = Colors.red,
}) {
  return Container(
    width: width,
    height: height,
    color: Colors.cyan,
    child: Stack(
      children: [
        Positioned(bottom: 0, right: 0, child: Text("$width, $height")),
        Positioned(top: 0, right: 0, child: Text("$width, 0")),
        const Positioned(top: 0, left: 0, child: Text("0,0")),
        Positioned(bottom: 0, left: 0, child: Text("0, $height")),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Align(
            child: Text("$width, $height"),
          ),
        ),
      ],
    ),
  );
}

class SeatMap extends StatelessWidget {
  const SeatMap({
    super.key,
    required this.theater,
    this.width = 333.3,
    this.height = 100.0,
  });

  final Map<String, dynamic> theater;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.none, // This does nothing.
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.topLeft,
        children: theater["tables"]
            .map<Widget>((table) => daam_table.Table(
                  table: table,
                  usableHeight: height,
                  usableWidth: width,
                ))
            .toList(),
      ),
    );
  }
}
