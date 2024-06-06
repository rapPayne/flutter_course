import 'package:flutter/material.dart';
import 'package:raw_state/raw_state.dart';

class PickSeats extends StatefulWidget {
  const PickSeats({super.key});

  @override
  State<PickSeats> createState() => _PickSeatsState();
}

class _PickSeatsState extends State<PickSeats> {
  DateTime selectedDate = rawState.get<DateTime>("selectedDate");
  Map<String, dynamic> selectedShowing =
      rawState.get<Map<String, dynamic>>("selectedShowing");
  Map<String, dynamic> cart = rawState.get("cart");
  Map<String, dynamic> theater = rawState.get<Map<String, dynamic>>("theater");

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;
    bool isPortrait = !isLandscape;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick your seats"),
      ),
      body: isPortrait ? tellUserToRotate() : seatMap(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // For debugging only - Load the cart up with data
          cart = {
            "showing_id": 100,
            "seats": [7, 8, 10, 22],
          };
          rawState.set("cart", cart);
          Navigator.pushNamed(context, "/checkout");
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  Widget seatMap() {
    return Container(
      alignment: Alignment.center,
      child: const Text("Seat map will go here."),
    );
  }

  Widget tellUserToRotate() {
    return Container(
      alignment: Alignment.center,
      child: const Text("Rotate your device to see a map of the theater."),
    );
  }
}
