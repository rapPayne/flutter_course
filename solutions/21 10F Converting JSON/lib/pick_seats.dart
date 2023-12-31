import 'package:daam/state/global.dart';
import 'package:flutter/material.dart';

class PickSeats extends StatefulWidget {
  const PickSeats({super.key});

  @override
  State<PickSeats> createState() => _PickSeatsState();
}

class _PickSeatsState extends State<PickSeats> {
  DateTime selectedDate = global.get<DateTime>("selectedDate");
  Map<String, dynamic> selectedShowing =
      global.get<Map<String, dynamic>>("selectedShowing");
  Map<String, dynamic> cart = global.get("cart");
  Map<String, dynamic> theater = global.get<Map<String, dynamic>>("theater");

  @override
  Widget build(BuildContext context) {
    print(selectedDate);
    print(selectedShowing);
    print(theater);
    return Column(
      children: [
        const Text("PickSeats"),
        FloatingActionButton(
          onPressed: () {
            // For debugging only - Load the cart up with data
            cart = {
              "showing_id": 100,
              "seats": [7, 8, 10, 22],
            };
            global.set("cart", cart);
            Navigator.pushNamed(context, "/checkout");
          },
        )
      ],
    );
  }
}
